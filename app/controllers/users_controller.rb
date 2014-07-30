class UsersController < ApplicationController
  def show
    if User.find_by_id(params[:id]) == nil
      redirect_to root_path
    else
      @user = User.find(params[:id])
      @posts = @user.posts.paginate(page: params[:posts], per_page: 3)
    end
  end
end
