class AddreadToChats < ActiveRecord::Migration[6.1]
  def change
     add_column :chats, :read, :boolean, default: false
  end
end
