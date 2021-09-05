class BooksController < ApplicationController

  before_action :authenticate_user!

  before_action :ensure_correct_user, only: [:edit]


  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to booklist_path(@book.id)
    else
      #@book = Book.new
      @books = Book.all
      @user = current_user
      render :index
    end
  end


  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    #@user = User.find(params[:id])
    @user = @book.user
  end

  def edit
    #@book = Book.find(params[:id])
    #if @book.user == current_user
      #@user = @book.user
      #render action: :edit
    #else
     # @user = @book.user
      #redirect_to booklist_path(@book.id)
    #end
    #@user = User.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to booklist_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to '/books'
    end

  end

end
