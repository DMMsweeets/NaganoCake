class Admin::OrdersController < ApplicationController
  	before_action :authenticate_admin!

	def index
    @orders = Order.page(params[:page]).per(8)
	end

	def show
		@order = Order.find(params[:id])
		@order_detail =
		@order_details = @order.order_details
	end

	def update
		order=Order.find(params[:id])
    order_details=OrderDetail.where(order_id: order.id)
    order.update(order_params)

		 if params[:order][:status] == "入金確認"
       order_details.each do |order_detail|
         order_detail.update(make_status: 1)
       end
     end
    redirect_to request.referer
	end

  private
	def order_params
		params.require(:order).permit(:status)
	end
end
