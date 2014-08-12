class CollectionsController < ApplicationController
  before_action :authenticate_user!,	only: [:create, :destroy]
  before_action :correct_user,		only: :destroy
  def show
    @current_collection = Collection.find(params[:id])
    @user = @current_collection.user
    
  end
  
  def create
    @collection = current_user.collections.build(collection_params)
    if @collection.save
      flash[:success] = "Collection created!"
      redirect_to collection_path(@collection)
    else
      flash[:danger] = "New collection Failed"
      redirect_to root_path
    end
  end

  def destroy
    @collection.destroy
    flash[:success] = "Collection deleted"
    redirect_to user_path(current_user)
  end

  private
  
    def collection_params
      params.require(:collection).permit(:name, :description)
    end
    
    def correct_user
      @collection = current_user.collections.find_by(id: params[:id])
      redirect_to root_path if @collection.nil?
    end
end
