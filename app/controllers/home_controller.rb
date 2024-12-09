class HomeController < ApplicationController
  before_action :authorize_super_user, only: [ :destroy ]
  def index
    @users =  User.includes(:roles).where(roles: { name: "MEMBER" })
  end

  def destroy
    user = User.find(params[:id])
    if user
      user.destroy
      redirect_to root_path, notice: "User removed successfully."
    else
      redirect_to root_path, alert: "User not found."
    end
  end

  private

  def authorize_super_user
    unless current_user&.super_user?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
