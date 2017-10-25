class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user
  def current_user
    puts "******* current_user *******"
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
    puts "@current_user: #{@current_user.inspect}"
  end
end
