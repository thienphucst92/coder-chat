class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:success] = "Welcome! Signed in."
        redirect_to inbox_path
      else
        flash.now[:error] = "Wrong password!"
        render 'new'
      end
    else
      flash.now[:error] = "User not found."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
