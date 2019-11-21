class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = @user.books.all
  end

  def edit
  	@user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def create
    
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] ="You have updated user successfully."
  	  redirect_to user_path(@user.id)
    else
      @users = User.all
      render "users/edit"
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = @user.books.all
    @users = User.all
    
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
	end
end
