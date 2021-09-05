class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
   # @book = Book.find(params[:id])
    @user = User.find(params[:id])
    @newbook = Book.new
    @book = @user.books
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to booklist_path(@book.id)
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
       redirect_to userlist_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to userlist_path(@user.id)
    else
      #@user = User.find(params[:id])
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end

