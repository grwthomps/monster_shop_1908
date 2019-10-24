class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = ["Congratulations #{@user.name}, you have registered and are now logged in!"]
      session[:user_id] = @user.id
      redirect_to '/profile'
    else
      flash.now[:failure] = @user.errors.full_messages.uniq
      render :new
    end
  end

  def show
    if current_user
      @user = User.find(session[:user_id])
    else
      render file: '/public/404'
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
