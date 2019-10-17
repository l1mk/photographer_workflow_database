require './config/environment'
#require 'pry'
class ApplicationController < Sinatra::Base
#require configuration for sessions and password to work
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
    redirect  "/"
    end
  end
#welcome screen after signup/sign in
  get "/login" do
    if !logged_in?
    erb :"photographers/login"
    else
    redirect  "/photographers"
    end
  end
#Request to clear all session and logout
  get "/logout" do
    if logged_in?
   session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end
#Additional Methods for login authentication
  helpers do
    def logged_in?
      !!session[:photographer_id]
    end

    def current_user
      Photographer.find(session[:photographer_id])
    end
  end
#end of helper method
end
