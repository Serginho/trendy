class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :post, index: true
      t.references :user, index: true
      t.float :score

      t.timestamps
    end
  end
end
