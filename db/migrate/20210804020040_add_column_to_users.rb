class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :baby_due_on, :date
  end
end
