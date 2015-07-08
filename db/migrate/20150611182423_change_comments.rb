class ChangeComments < ActiveRecord::Migration
  def change
  	add_column :comments, :cmttitle, :string
  	change_column :comments, :comment, :text
  end
end
