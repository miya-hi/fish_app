class CreateFish < ActiveRecord::Migration[5.2]
  def change
    create_table :fish do |t|
      t.string :name, null: false
      t.string :line, null: false
      t.float :n3_oil, null: false
      t.boolean :n3_oil_no_data
      t.integer :vitamin_a, null: false
      t.boolean :vitamin_a_tr
      t.boolean :vitamin_a_no_data
      t.float :mercury
      t.text :content
      t.string :image
      t.timestamps
      t.index :line
    end
  end
end
