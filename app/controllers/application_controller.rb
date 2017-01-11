require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash, :sweep => true
  end

  helpers do
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] != nil
      # db.conn.exec("SELECT * FROM users WHERE id = ?", session[:user_id])
    end

    def is_logged_in?
      !!current_user
    end
  end

  get "/" do
    if is_logged_in?
      flash[:message] = "You are already logged in" #working
      redirect '/books'
    else
      erb :index
    end
  end

end
