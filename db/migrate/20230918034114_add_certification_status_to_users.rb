class AddCertificationStatusToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :certification_status, :integer, default: 0
  end
end
