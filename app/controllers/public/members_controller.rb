class Public::MembersController < ApplicationController
  before_action :authenticate_member!

  # マイページ
  def show
    @member = current_member
  end

  #ユーザ編集画面を表示する
  def edit
    @member = current_member
  end

  def update
    @member = current_member
        if @member.update(member_params)
           flash[:success] = "登録情報を変更しました。"
           redirect_to public_mypage_path(@member)
        else
            render 'edit'
        end
  end

  #今回なし
  def unsubscribe
  end

  #論理的削除の退会機能
  def withdrawal
    member = current_member
    #is_deletedカラムにフラグを立てる(default→false(有効状態)をtrue(無効状態)にする）
    member.update(is_deleted: true)
    #ログアウトさせる
    reset_session

    flash[:notice] = "ありがとうございました。またお待ちしております。"
    redirect_to root_path
  end




    # ストロングパラメーター
    private

  	def member_params
  		params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :address, :postal_code, :phone_number, :email, :is_deleted)
  	end

  	#退会済みユーザーへの対応(これ、なくても動くけど一応)
    def member_is_deleted
      if member_signed_in? && current_member.is_deleted?
         redirect_to root_path
      end
    end

end
