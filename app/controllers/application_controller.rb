require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
#require configuration for sessions and password to work
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash, :sweep => true
    set :session_secret, "password_security"
  end
#home screen where you can sign in
  get "/" do
    erb :index
  end
#Request to clear all session and logout
  get "/logout" do
    if logged_in?
      session.clear
      flash[:message] = "Successfully Logout"
      redirect "/login"
    else
      redirect "/"
    end
  end
#Additional Helper Methods for login authentication
  helpers do
    def logged_in?
      !!session[:photographer_id]
    end

    def current_user
      Photographer.find(session[:photographer_id])
    end
  end

end
