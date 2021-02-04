class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edi]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @book_id = Book.find(params[:id])
    @book_comment = BookComment.new

  end

  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
