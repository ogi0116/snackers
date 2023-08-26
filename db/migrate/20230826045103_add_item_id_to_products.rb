class AddItemIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :item_id, :integer
  end
end
