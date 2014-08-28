class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
     @post = current_user.posts.build
     @feed_items = current_user.feed.paginate(page: params[:feeds], per_page: 10)
    end
  end

  def help
  end

  def about
  end

  def search
    @users = User.paginate(page: params[:users]).search(params[:search])
  end
end
