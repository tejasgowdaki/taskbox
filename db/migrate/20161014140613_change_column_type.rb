class ChangeColumnType < ActiveRecord::Migration
  def change
  	change_column :projects, :budget, :float
  end
end
