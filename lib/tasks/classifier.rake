namespace :classifier do
  desc "Convert training set from database to a vectors file"
  task dataconvert: :environment do
    Classifier.data_converter('training_set', 'lib/svm_model/')
  end


  desc "Traing support vector machine"
  task train: :environment do
    Classifier.train 'lib/svm_model/training_set', 'lib/svm_model/'
  end

end
