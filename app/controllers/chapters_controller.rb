class ChaptersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :correct_user, only: [:destroy, :update]
  
  def create
    @chapter = current_book.chapters.build(chapter_params(:chapter))
    if @chapter.save 
      flash[:success] = "Chapter created!"
      redirect_to book_path(@current_book, {:c => @chapter.slug})
    else
      flash[:danger] = @chapter.errors.full_messages
      redirect_to book_path(@current_book)
    end
  end
  
  private
  
  def current_book
    @current_book = Book.friendly.find(params[:book_id])
  end

  def chapter_params(chapter)
    params.require(chapter).permit(:name)
  end
  

  def correct_user
    @chapter = current_user.books.friendly.find(params[:id]).chapter.friendly.find(params[:c])
    redirect_to book_path(@book) if @chapter.nil?
  end
end