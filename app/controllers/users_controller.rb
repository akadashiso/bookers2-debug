class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    # @book_id = Book.find(params[:id])
    @book_comment = BookComment.new
    @relationship = @user.relationships.find_by(follow_id: @user.id)
    @set_relationship = @user.relationships.new

  end

  def index
    @user = current_user
    @book = Book.new
    @users = User.all
    @relationship = @user.relationships.find_by(follow_id: @user.id)
    @set_relationship = @user.relationships.new
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

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.all
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
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
