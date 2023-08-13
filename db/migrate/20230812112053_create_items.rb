class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.string :company

      t.timestamps
    end
  end
end
