class UsersController < ApplicationController
	before_filter :authenticate_user!
  def index
  	authorize! :index, @user, message: "Not authorized as an administrator"
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  private
  	def secure_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation, :remember_me)
  	end
end
