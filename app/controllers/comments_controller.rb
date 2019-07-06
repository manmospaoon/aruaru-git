class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.theme_id = params[:theme_id]


    if @comment.save
      flash[:success] = 'あるあるを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      @theme = Theme.find(params[:theme_id])
      @comments = @theme.comments.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'あるあるの投稿に失敗しました。'
      render('themes/show')
    end
  end
  
  def edit
  end
  
  def update
     if @comment.update(comment_params)
      flash[:success] = 'あるあるを編集しました。'
      redirect_to("/users/#{@comment.user_id}")
     else
      flash.now[:danger] = 'あるあるの編集に失敗しました。'
      render('comments/edit')
     end
  end
  
  def destroy
    @comment.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :theme_id)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
