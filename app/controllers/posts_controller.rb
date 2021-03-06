class PostsController < ApplicationController

  def index
    if session[:user_id] then
      @posts = Post.posts_for_index(session[:user_id])
    else
      @posts = Post.posts_for_index
    end
  end

  def category
    @posts_by_category = Post.includes(:category).where(category_id: params[:id]).order('created_at DESC').paginate(page: params[:page], per_page: 15)
  end

  def search
    if params[:query] then
      keywords = params[:query].split ' '
      keywords = keywords.map { |k| k.downcase}
      @posts = Post.includes(:category)
      keywords.each do |k|
        @posts = @posts.where('lower(title) LIKE ?', "%#{k}%")
      end
      @posts.all
    else
      render "search_mobile"
    end
  end
end