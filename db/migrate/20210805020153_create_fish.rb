class CreateFish < ActiveRecord::Migration[5.2]
  def change
    create_table :fish do |t|
      t.string :name
      t.string :line
      t.float :n3_oil
      t.float :vitamin_a
      t.float :mercury
      t.text :content
      t.string :image
      t.timestamps
    end
  end
end
