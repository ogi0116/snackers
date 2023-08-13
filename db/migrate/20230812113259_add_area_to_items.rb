class AddAreaToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :area, :string
  end
end
