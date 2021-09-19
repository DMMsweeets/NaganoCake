class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_member.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.price * cart_item.amount * 1.1}
    # sum：合計金額を出す
    # 1行目の@cart_itemsにsumメソッドを用いて{}の||ブロック変数にcart_itemを代入
    # cart_item.item.price：アソシエーションしているのでドットでつなげる
    # 『このcart_itemのitemのprice』 → 『このカート商品の商品（単体）の税抜き価格』
    # cart_item.amount：『このカート商品の個数』
  end

  def create
    @cart_item = CartItem.new(cart_create_params)
    @cart_item.member_id = current_member.id
    @cart_item.item_id = params[:item_id]

    if @cart_item.save
      flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
      redirect_to public_cart_items_path
    else
      flash[:notice] = "個数を選択してください"
      render "public/cart_items/index"
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "#{@cart_item.item.name}を削除しました"
    redirect_to public_cart_items_path

  end

  def destroy_all
    @cart_item = current_member.cart_items
    @cart_item.destroy_all
    flash[:notice] = "カートの商品を全て削除しました"
    redirect_to public_cart_items_path
  end



  private
   #.require(:cart_item)

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :member_id)
  end

  def cart_create_params
    params.permit(:amount, :item_id, :member_id)
  end

end
