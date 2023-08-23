class Public::ReportsController < ApplicationController
   before_action :authenticate_user!

 def new
   @report = Report.new
   @item = Item.find(params[:item_id])
 end

  def create
    item = Item.find(params[:item_id])
    report = current_user.reports.new(report_params)
    report.item_id = item.id
    report.save
    redirect_to complete_item_path(item)
  end

  private

  def report_params
    params.require(:report).permit(:report)
  end

end
