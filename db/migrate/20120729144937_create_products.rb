class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :status
      t.text :description
      t.decimal :price
      t.string :phone
      t.string :email
      t.timestamps
    end
  end
end
