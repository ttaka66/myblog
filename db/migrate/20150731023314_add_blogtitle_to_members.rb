class AddBlogtitleToMembers < ActiveRecord::Migration
  def change
    add_column :members, :blog_title, :text
  end
end
