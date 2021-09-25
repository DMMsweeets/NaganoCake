class Public::OrdersController < ApplicationController

  def index
    @orders = Order.page(params[:page]).per(6)
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.where(order_id: @order.id)
  end

  def new
    @order = Order.new
  end

  def create
    @cart_items = current_member.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.price * cart_item.amount * 1.1}
    @postage = 800
    @order = Order.new(order_params)
    @tax_price = @order.total_price + @postage
    if @order.save
      @cart_items.each{|cart_item| OrderDetail.create(order_id: @order.id, item_id: cart_item.item.id, amount: cart_item.amount, tax_price: @tax_price)}
      @cart_items.each{|cart_item| cart_item.destroy}
      redirect_to public_complete_path
    end
  end

  def complete
  end

  def confirm
    @order = Order.new
    @cart_items = current_member.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.price * cart_item.amount * 1.1}
    @tax_price = @total_price + 800
    @order.payment = params[:payment]

    if params[:address_value] == "0"
      @order.name = current_member.full_name
      @order.address = current_member.address
      @order.postal_code = current_member.postal_code
    elsif params[:address_value] == "1"
      @address = params[:address].to_i
      @delivery = Delivery.find(@address)
      @order.name = @delivery.name
      @order.address = @delivery.address
      @order.postal_code = @delivery.postal_code
    elsif params[:address_value] == "2"
      @order.name = params[:new_name]
      @order.address = params[:new_address]
      @order.postal_code = params[:new_postal_code]
    end
  end


  private

  def order_params
    params.require(:order).permit(:payment, :name, :address, :postal_code, :member_id, :total_price, :postage)
          .merge(member_id: current_member.id, total_price: @total_price, postage: @postage)
  end
end