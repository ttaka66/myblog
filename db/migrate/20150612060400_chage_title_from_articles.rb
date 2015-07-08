class ChageTitleFromArticles < ActiveRecord::Migration
  def change
  	change_column :articles, :title, :string
  end
end
