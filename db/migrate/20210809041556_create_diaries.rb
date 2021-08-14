class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.integer :amount, null: false
      t.datetime :input_at, null: false
      t.references :user, null: false, foreign_key: true
      t.references :fish, null: false, foreign_key: true
      t.timestamps
    end
  end
end
