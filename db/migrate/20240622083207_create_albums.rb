class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.integer :sharing_mode

      t.timestamps
    end
  end
end
