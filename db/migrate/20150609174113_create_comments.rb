class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :member, index: true
      t.references :article, index: true
      t.string :comment

      t.timestamps
    end
  end
end
