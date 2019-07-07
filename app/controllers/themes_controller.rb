class ThemesController < ApplicationController
  before_action :require_user_logged_in, only:[:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @themes = Theme.order(id: :desc).page(params[:page]).per(6)
  end
  
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
      flash[:success] = 'お題を投稿しました。'
      redirect_to "/users/#{@theme.user.id}/created_themes"
    else
      flash.now[:danger] = 'お題の投稿に失敗しました。'
      render 'themes/new'
    end
  end

  def edit
  end
  
  def update
    if @theme.update(theme_params)
      flash[:success] = 'お題を編集しました。'
      redirect_to("/users/#{@theme.user.id}/created_themes")
    else
      flash.now[:danger] = 'お題の編集に失敗しました。'
      render('themes/edit')
    end
  end
  
  def destroy
    @theme.destroy
    flash[:success] = 'お題を削除しました。'
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
