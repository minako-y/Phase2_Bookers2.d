class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    if params[:sort_create]
      @books = Book.order(created_at: :desc)
    elsif params[:sort_rate]
      @books = Book.order(rate: :desc)
    elsif category_search?
      category = params[:category_search]
      @books = Book.where(category: category)
    else
      @books = Book.all
    end
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body, :rate, :category)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
  
  def category_search?
    params[:category_search].present?
  end
  
end
