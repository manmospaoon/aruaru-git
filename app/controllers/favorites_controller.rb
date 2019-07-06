class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    comment = Comment.find(params[:comment_id])
    current_user.like(comment)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    current_user.unlike(comment)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
