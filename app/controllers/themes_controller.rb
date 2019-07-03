class ThemesController < ApplicationController
  before_action :require_user_logged_in, only:[:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def show
    @theme = Theme.find(params[:id])
    @comments = @theme.comments.order(id: :desc).page(params[:page]).per(4)
    @comment = @theme.comments.build
  end
  
  def new
    @theme = Theme.new
  end
  
  def create
    @theme = current_user.themes.build(theme_params)
    @themes = current_user.themes.order(id: :desc).page(params[:page])
    if @theme.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'themes/new'
    end
  end

  def destroy
    @theme.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def theme_params
    params.require(:theme).permit(:content)
  end
  
  def correct_user
    @theme = current_user.themes.find_by(id: params[:id])
    unless @theme
      redirect_to root_url
    end
  end
end
