class UsersController < ApplicationController
	before_filter :authenticate_user!

  def index
  	authorize! :index, @user, message: "Not authorized as an administrator"
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def update
  	authorize! :update, @user, message: "Not authorized as an administrator"
  	@user = User.find(params[:id])
  	if @user.update_attributes(secure_params)
  		redirect_to user_path, notice: "User updated"
  	else
  		redirect_to user_path, alert: "Unable to update user"
  	end
  end

  def destroy
  	authorize! :destroy, @user, message: "Not authorized as an administrator"
  	user = User.find(params[:id])
  	if user == current_user
  		redirect_to users_path, notice: "Can't delete yourself"
  	else
  		user.destroy
  		redirect_to users_path, notice: "User deleted"
  	end
  end
  private
  	def secure_params
  		if current_user && (current_user.has_role? :admin)
  			params.require(:user).permit(:role_ids,:name, :email, :password, :password_confirmation, :remember_me)	
  		else
	  		params.require(:user).permit(:name, :email, :password, :password_confirmation, :remember_me)
  		end
  	end
end
