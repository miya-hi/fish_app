class CreateFish < ActiveRecord::Migration[5.2]
  def change
    create_table :fish do |t|
      t.string :name, null: false
      t.string :line, null: false
      t.float :n3_oil, null: false
      t.integer :vitamin_a, null: false
      t.float :mercury
      t.text :content
      t.string :image
      t.timestamps
    end
  end
end
