class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :password
      t.date :birthday
      t.string :comefrom
      t.string :interest
      t.string :ctype
      t.binary :photo
      t.integer :comments_count

      t.timestamps
    end
  end
end
