class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :item_id
      t.integer :user_id
      t.text :report

      t.timestamps
    end
  end
end
