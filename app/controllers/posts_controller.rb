class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, 		only: :destroy

  def create
    @post = current_user.posts.build(posts_params)
    @feed_items = current_user.feed.paginate(page: params[:feeds], per_page: 10)
    if @post.save
      @post = current_user.posts.build
      flash[:success] = "Status updated!"
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
     flash[:danger] = @post.errors.full_messages
     render 'static_pages/home'
    end
  end
 
  def destroy
    @post.destroy
    flash[:danger] = "Status deleted"
    redirect_to root_path
  end

  private
  
  def posts_params
    params.require(:post).permit(:content)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_path if @post.nil?
  end
end
