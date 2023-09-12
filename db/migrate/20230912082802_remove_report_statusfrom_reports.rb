class RemoveReportStatusfromReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :Report_status, :integer, default: 0
  end
end
