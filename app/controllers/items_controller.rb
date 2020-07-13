class ItemsController < ApplicationController
  def index
    @keyword = params.permit(:keyword).to_h
  end
end
