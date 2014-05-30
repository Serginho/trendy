class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :post
      t.references :user
      t.references :site

    end
    add_index :shares, [:post_id, :user_id, :site_id], unique: true
  end
end
