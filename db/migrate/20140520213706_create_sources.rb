class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.string :url
    end
    add_foreign_key :posts, :sources
  end
end
