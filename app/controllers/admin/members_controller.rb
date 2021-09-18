class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!,only: [:show,:edit,:update,:index]
  def index
    @members = Member.page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
     @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to admin_members_path
    else
      flash[:notice] = "すべての項目を入力してください"
      redirect_to edit_admin_member_path(@member)
    end
  end

  private
  def member_params
    params.require(:member).permit(:email,:first_name,:last_name,:first_name_kana,:last_name_kana,:address,:postal_code,:phone_number,:is_deleted)
  end
end
