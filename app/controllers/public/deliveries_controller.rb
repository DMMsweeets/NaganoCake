class Public::DeliveriesController < ApplicationController
  def index
    @deliveries = Delivery.all
    @delivery = Delivery.new
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def create
   @delivery = Delivery.new(delivery_params)
    if @delivery.save
      flash[:notice] = "登録が完了しました！"
      redirect_to public_deliveries_path
    else
      @deliveries = Delivery.all
      flash[:notice] = "すべての項目を入力してください"
      render :index
    end
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      flash[:notice] = "編集が完了しました！"
      redirect_to public_deliveries_path
    else
      flash[:notice] = "すべての項目を入力してください"
      render :edit
    end
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    flash[:notice] = "登録情報を削除しました！"
    redirect_to public_deliveries_path
  end
end

private

  def delivery_params
    params.require(:delivery).permit(:postal_code, :address, :name, :member_id).merge(member_id: current_member.id)
  end