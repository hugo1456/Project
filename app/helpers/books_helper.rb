module BooksHelper

  def current_book
    @current_book ||= Book.friendly.find(params[:id])
  end

end