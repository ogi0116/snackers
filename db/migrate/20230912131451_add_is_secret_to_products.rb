class AddIsSecretToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :is_secret, :boolean, default: false, null: false
  end
end
