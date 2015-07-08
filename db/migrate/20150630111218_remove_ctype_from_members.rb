class RemoveCtypeFromMembers < ActiveRecord::Migration
  def change
  	remove_column :members, :ctype
  	change_column :members, :photo, :string
  end
end
