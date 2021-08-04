class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :baby_due_on, :date
  end
end
