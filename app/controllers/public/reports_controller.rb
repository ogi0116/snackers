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
    if report.save
      item.update(status: 0)
      flash[:notice] = "管理者に報告しました"
      redirect_to complete_item_path(item)
    else
      @report = Report.new
      @item = Item.find(params[:item_id])
      flash[:alert] = "正しい内容を入力してください"
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:report)
  end

end
