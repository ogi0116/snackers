class AddReportStatusToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :Report_status, :integer, default: 0
  end
end
