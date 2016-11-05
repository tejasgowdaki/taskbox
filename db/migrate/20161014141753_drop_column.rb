class DropColumn < ActiveRecord::Migration
  def change
  	remove_column :projects, :estimated_budget
  end
end
