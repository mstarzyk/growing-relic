class PostsController < ApplicationController
  # GET
  def index
    render json: {"action": "index", "status": "OK"}
  end

  # POST
  def create
    render json: {"action": "create", "status": "OK"}
  end
end
