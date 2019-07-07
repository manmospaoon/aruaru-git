class ApplicationController < ActionController::Base
  include SessionsHelper
  
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_comments = user.comments.count
    @count_likes = user.fav_comments.count
    @count_themes = user.themes.count
  end
end
