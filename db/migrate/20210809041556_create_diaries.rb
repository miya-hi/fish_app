class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.integer :amount
      t.datetime :input_at
      t.references :user, null: false, foreign_key: true
      t.references :fish, null: false, foreign_key: true
      t.timestamps
    end
  end
end
