class ToppagesController < ApplicationController
  def index
    @themes = Theme.order(id: :desc).page(params[:page])
    @comments = Comment.order(id: :desc).page(params[:page]).per(8)
  end
end
