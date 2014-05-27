class PostsController < ApplicationController

  def index
    @posts = Post.includes(:category).all
  end

  def category
    @posts_by_category = Post.includes(:category).where(category_id: params[:id]).order('created_at DESC')
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