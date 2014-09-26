class CollectionsController < ApplicationController
  before_action :authenticate_user!,	only: [:create, :destroy, :update]
  before_action :correct_user,		only: [:destroy, :update]

  def show
    @current_collection = Collection.friendly.find(params[:id])
    @user = @current_collection.user   
    @books = @current_collection.books
  end
  
  def create
    @collection = current_user.collections.build(collection_params(:collection))
    if @collection.save
      flash[:success] = "Collection created!"
      redirect_to collection_path(@collection)
    else
      flash[:danger] = @collection.errors.full_messages
      redirect_to root_path
    end
  end

  def destroy
    @collection.destroy
    flash[:success] = "Collection deleted"
    redirect_to user_path(current_user)
  end
  
  def update
    if @collection.update_attributes(collection_params(:current_collection))
      @collection.slug = nil
      @collection.save!
      flash[:success] = "Collection Updated"
      redirect_to @collection
    else
      flash[:danger] = @collection.errors.full_messages
      redirect_to @collection
    end
  end

  private
  
    def collection_params(collection)
      params.require(collection).permit(:name, :description)
    end
    
    def correct_user
      @collection = current_user.collections.friendly.find(params[:id])
      redirect_to root_path if @collection.nil?
    end
end
