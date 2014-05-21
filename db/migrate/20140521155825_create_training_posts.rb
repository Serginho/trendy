class CreateTrainingPosts < ActiveRecord::Migration
  def change
    create_table :training_posts do |t|
      t.string :title
      t.text :content
      t.references :category
    end
    add_foreign_key :training_posts, :categories
  end
end
