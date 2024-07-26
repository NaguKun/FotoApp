class CreateReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true
      t.integer :reaction_type, null: false
      t.timestamps
    end
    add_index :reactions, [:user_id, :photo_id], unique: true
  end
end