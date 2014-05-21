class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :image
      t.string :url
      t.references :category
      t.references :source

      t.timestamps
    end
    add_foreign_key :posts, :categories
    add_index :posts, :title , unique: true
  end
end
