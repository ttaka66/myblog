class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :member, index: true
      t.integer :title
      t.text :article

      t.timestamps
    end
  end
end
