class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :introduction
      t.integer :price
      t.integer :active_status
      t.integer :genre_id
      t.integer :user_id

      t.timestamps
    end
  end
end
