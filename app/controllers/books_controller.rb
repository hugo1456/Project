class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :correct_user, only: [:destroy, :update]

  def show
    @current_book = Book.friendly.find(params[:id])
    @current_collection = @current_book.collection
    @user = @current_book.collection.user
    @books = @current_collection.books
  end
  
  def create
    @book = current_collection.books.build(book_params(:book))
    if @book.save
      flash[:success] = "Book created!"
      redirect_to book_path(@book)
    else
      flash[:danger] = @book.errors.full_messages
      redirect_to root_path
    end
  end
  
  def destroy
    @book.destroy
    flash[:success] = "Book deleted"
    redirect_to collection_path(@book.collection)
  end
  
  private
  
  def current_collection
    @current_collection = Collection.friendly.find(params[:collection_id])
  end
  
  def book_params(book)
    params.require(book).permit(:name, :description)
  end
  
  def correct_user
    @book = current_user.books.friendly.find(params[:id])
    redirect_to root_path if @book.nil?
  end

end