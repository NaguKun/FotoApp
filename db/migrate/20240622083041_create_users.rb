class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :firstname
      t.string :lastname
      t.integer :photos_count
      t.integer :albums_count

      t.timestamps
    end
    add_index :users, :email
  end
end
