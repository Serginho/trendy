require 'libsvm'
require 'extension/training_set'
require 'fileutils'

module Classifier

  def self.data_converter(filename, path)
    posts = TrainingPost.all.order(:category_id)
    training = TrainingSet.new

    counter = 0
    puts 'Loading data...'
    posts.each do |post|
      doc = Document.new post.title + post.content, post.category_id
      training.add_document doc
      puts counter
      counter += 1
    end

    puts 'Converting data...'
    counter = 0

    File.open(path+filename, 'w') do |file|
      training.documents.each do |document|
        str = document.category_id.to_s + " "
        words = document.words_uniq
        words.sort! do |x, y|
          training.get_diccionary_position(x) <=> training.get_diccionary_position(y)
        end
        words.each do |word|
          str += training.get_diccionary_position(word).to_s+":"+(document.tf(word) * training.idf(word)).to_s + " "
        end
        file.puts str

        puts counter
        counter += 1
      end
    end

    File.open(path+filename+"_object", "w") do |file|
      Marshal.dump(training, file)
    end
    puts 'Finished!'
  end

  def self.train(training_set, model_save)
    categories = []
    ar_categories = Category.all.order(:id)
    ar_categories.each do |c|
      categories << c.id
    end
    counter = 0
    vectors_train = []
    categories_v = []

    problems = Hash.new

    categories.each_with_index do |c,i|
      j = i+1
      while j < categories.length
        problems["#{c}y#{categories[j]}"] =  Libsvm::Problem.new
        j+=1
      end
    end

    parameter = Libsvm::SvmParameter.new
    parameter.svm_type = Libsvm::SvmType::C_SVC
    parameter.kernel_type = Libsvm::KernelType::LINEAR
    parameter.cache_size = 8 # in megabytes
    parameter.eps = 0.0001
    parameter.c = 10

    File.open(training_set, 'r').each do |line|
      values = Hash.new
      data = line.split(' ')

      data.each_with_index do |v, i|
        if i == 0
          categories_v << v.to_i
        else
          a = v.split(':')
          values[a[0].to_i] = a[1].to_f
        end
      end
      vectors_train << Libsvm::Node.features(values)
      counter +=1

      puts counter
    end

    problems.each do |cat, problem|
      cats = cat.split('y')
      vector_c = []
      vector_t = []
      vectors_train.each_with_index do |node,i|
        if (categories_v[i] == cats[0].to_i || categories_v[i] == cats[1].to_i)
          vector_c << categories_v[i]
          vector_t << node
        end
      end
      problem.set_examples(vector_c, vector_t)
    end

    model = Hash.new

    problems.each do |cat, problem|
      puts "Training #{cat}..."
      model[cat] = Libsvm::Model.train(problem, parameter)
      fn = model_save + "model#{cat}"
      model[cat].save fn
    end
  end

  def self.get_models(path)
    fn = []
    categories = []
    ar_categories = Category.all.order(:id)
    ar_categories.each do |c|
      categories << c.id
    end
    categories.each_with_index do |c,i|
      j = i+1
      while j < categories.length
        fn << path + "model#{c}y#{categories[j]}"
        j+=1
      end
    end
    models = []
    fn.each do |filename|
      models << Libsvm::Model.load(filename)
    end

    models
  end

  def self.classify(models, content, path, filename)
    training = Marshal.load(File.open(path+filename+"_object", "r"))
    doc = Document.new content
    vector = Hash.new(0)
    words = doc.words_uniq

    words.each do |word|
      vector[training.get_diccionary_position(word).to_i] = (doc.tf(word) * training.idf(word)).to_f
    end

    predictions = Hash.new(0)
    models.each do |model|
      pred = model.predict(Libsvm::Node.features(vector))
      predictions[pred.to_i] += 1
    end
    final_prediction = predictions.max_by { |k,v| v}[0]

    final_prediction.to_i
  end

end