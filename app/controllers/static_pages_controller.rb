class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @query = params[:q].to_s.strip
      @feed_items = current_user.feed.search(@query).paginate(page: params[:page], per_page: 10)
    end
  end

  def help
  end
end
