class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :correct_user, only: [:destroy, :update]

  def show
    if Book.friendly.find(params[:id]) == nil
      redirect_to root_path
    else
      @current_book = Book.friendly.find(params[:id])
      @current_collection = @current_book.collection
      @user = @current_book.collection.user
      @books = @current_collection.books
      @chapters = @current_book.chapters if @current_book.chapters.any?
      unless params[:c].blank?
        @current_chapter = @current_book.chapters.friendly.find(params[:c])
      end
    end
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
  
  def update
    if @book.update_attributes(book_params(:current_book))
      @book.slug = nil
      @book.save!
      flash[:success] = "Book Updated"
      redirect_to @book
    else
      flash[:danger] = @book.errors.full_messages
      redirect_to collection_path(@book.collection)
    end
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