class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :fav_comments]
  
  
  def index
  end

  def show
   @user = User.find(params[:id])  
   @comments = current_user.comments.order(id: :desc).page(params[:page]).per(6)
   counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'アカウントを登録しました'
      redirect_to @user
    else
      flash[:danger] = 'アカウントの登録に失敗しました'
      render :new
    end
  end
  
  def fav_comments
    @user = User.find(params[:id])
    @fav_comments = @user.fav_comments.page(params[:page]).per(6)
    counts(@user)
  end
  
  def created_themes
    @user = User.find(params[:id])
    @created_themes = @user.themes.page(params[:page]).per(6)
    counts(@user)
  end
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end