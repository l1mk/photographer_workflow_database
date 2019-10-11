require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

#home screen where you can sign in
  get "/" do
    erb :index
  end
#welcome screen after signup/sign in
  get "/signup" do
    if !logged_in?
    erb :"photographers/new"
    else
    redirect  "/welcome"
    end
  end
#welcome screen after signup/sign in
  get "/login" do
    if !logged_in?
    erb :"photographers/login"
    else
    redirect  "/welcome"
    end
  end

  get "/logout" do
    if logged_in?
   session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end


  helpers do
    def logged_in?
      !!session[:photographer_id]
    end

    def current_user
      Photographer.find(session[:photographer_id])
    end
  end

end
