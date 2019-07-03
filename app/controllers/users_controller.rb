class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  
  def index
  end

  def show
   @user = User.find(params[:id])  
   @comments = current_user.comments.order(id: :desc).page(params[:page]).per(8)
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
  
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end