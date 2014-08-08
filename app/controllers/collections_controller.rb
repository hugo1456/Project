class CollectionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @collection = current_user.collections.build(collection_params)
    if @collection.save
      flash[:success] = "Collection created!"
      redirect_to collection_path(@collection)
    else
      flash[:error] = "New collection Failed"
      redirect_to root_path
    end
  end

  private
  
    def collection_params
      params.require(:collection).permit(:name, :description)
    end
end
