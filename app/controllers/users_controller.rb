class UsersController < ApplicationController
  def show
    if User.find_by_id(params[:id]) == nil
      redirect_to root_path
    else
      @user = User.find(params[:id])
      @posts = @user.posts.paginate(page: params[:posts], per_page: 3)
      @collections = @user.collections.paginate(page: params[:collections], per_page: 12)
    end
  end

    def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:users])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:users])
    render 'show_follow'
  end
end
