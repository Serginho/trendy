class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # Load dropdown categories
  before_filter :load_categories

  # Load current user
  before_filter :current_user

  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/not_found', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end

  def server_error
    respond_to do |format|
      format.html { render template: 'errors/internal_error', layout: 'layouts/application', status: 500 }
      format.all  { render nothing: true, status: 500}
    end
  end

  private
  def load_categories
    @current_page = params[:id]
    @categories = Category.all
  end

  def current_user
    #@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    @current_user = User.find_by(id: session[:user_id])
  end
end
