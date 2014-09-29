module CollectionsHelper
  def current_collection
    @current_collection ||= Collection.friendly.find(params[:id])
  end

  private

end
