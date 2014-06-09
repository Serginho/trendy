class CreateCustomizes < ActiveRecord::Migration
  def change
    create_table :customizes do |t|
      t.references :user, index: true
      t.references :category, index: true
      t.integer :rank
    end
  end
end
