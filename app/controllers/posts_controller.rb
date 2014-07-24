class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      flash[:success] = "Status updated!"
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end
 
  def destroy
  end

  private
  
  def posts_params
    params.require(:post).permit(:content)
  end
end
