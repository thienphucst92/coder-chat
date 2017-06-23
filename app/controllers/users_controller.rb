class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to FastText!"
      redirect_to root_path
    else
      flash.now[:error] = "#{@user.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
