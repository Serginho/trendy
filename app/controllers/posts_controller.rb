class PostsController < ApplicationController

  def index
    @posts = Post.includes(:category).all
  end

  def category
    @posts_by_category = Post.includes(:category).where(category_id: params[:id]).order('created_at DESC')
  end
end
