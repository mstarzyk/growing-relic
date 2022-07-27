#!/usr/bin/env bash

set -Eeuo pipefail

cd /root

rails new growing-relic --api --skip-active-record
cd growing-relic
rails g resource post

cat <<HEREDOC >app/controllers/post_controller.rb
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
HEREDOC
