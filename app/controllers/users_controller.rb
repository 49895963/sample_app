class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

    def user_params
      permitted = params.require(:user).permit(:name, :email, :password, :password_confirmation)

      if permitted[:password].blank?
        permitted.delete(:password)
        permitted.delete(:password_confirmation)
      end

      permitted
    end
end