class ToppagesController < ApplicationController
  def index
    @themes = Theme.order(id: :desc).page(params[:page])
  end
end
