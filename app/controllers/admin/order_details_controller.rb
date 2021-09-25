class Admin::OrderDetailsController < ApplicationController
 	before_action :authenticate_admin!

    def update
		order_detail = OrderDetail.find(params[:id])
		order = order_detail.order
        order_details=OrderDetail.where(order_id: order.id)
		order_detail.update(order_detail_params)

     if params[:order_detail][:make_status] == "制作中"
       order.update(status: 2)
       redirect_to request.referer

     elsif params[:order_detail][:make_status] == "制作完了"
       if order_details.all?{|order_detail| order_detail.make_status == "制作完了"}
         order.update(status: 3)
       end
       redirect_to request.referer
     else
       redirect_to request.referer
     end

	end

	private

     def order_detail_params
		 params.require(:order_detail).permit(:make_status)
	 end

end
