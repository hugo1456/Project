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
  
  def update
    @chapter.name = params[:content][:chapter_title][:value]
    @chapter.content = params[:content][:chapter_content][:value]
    @chapter.slug = nil
    @chapter.save!
    render text: ""
  end
  
  def destroy
    @chapter.destroy
    flash[:success] = "Chapter deleted"
    redirect_to book_path(@chapter.book)
  end
  
  private
  
  def current_book
    @current_book = Book.friendly.find(params[:book_id])
  end

  def chapter_params(chapter)
    params.require(chapter).permit(:name, :content)
  end
  

  def correct_user
    @chapter = Chapter.friendly.find(params[:id])
    redirect_to book_path(@book) unless @chapter.book.collection.user = current_user
  end
end