require './config/environment'
#require 'pry'
class PhotographersController < Sinatra::Base
#require configuration for sessions and password to work
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end
#bring the welcome website after login in
    get "/photographers" do
      if logged_in?
        @photographer = Photographer.find_by_id(session[:photographer_id])
        @photographers = Photographer.all
        @sessions = Session.all
        @clients = Client.all
        erb :"/photographers/welcome"
      else
        redirect "/login"
      end
    end
#take params from new, create photographer user, login in the user and redirect to the welcome website
    post "/signup" do
      if !params[:firstname].empty? && !params[:lastname].empty? && !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
        @photographer = Photographer.new(:firstname => params[:firstname], :lastname => params[:lastname], :username => params[:username], :email => params[:email], :password => params[:password])
          if @photographer.save
            session[:photographer_id] = @photographer.id
            redirect "/photographers"
          else
            redirect "/signup"
          end
      else
        redirect "/signup"
      end
    end
#take params from login, login in the user and redirect to the welcome website
    post "/login" do
        @photographer = Photographer.find_by(:username => params[:username])
        if @photographer && @photographer.authenticate(params[:password])
          session[:photographer_id] = @photographer.id
          redirect "/photographers"
        else
          redirect "/login"
        end
    end
#open up the details of photographer profile
    get "/photographers/:slug" do
      @photographer = Photographer.find_by_slug(params[:slug])
      erb :"/photographers/show", :layout => :"views/layout"
    end
#open up the editing form for photographer
    get "/photographers/:slug/edit" do
      @photographer = Photographer.find_by_slug(params[:slug])
      @sessions = Session.all
      @clients = Client.all
      erb :'photographers/edit'
    end
#take params from edit to update the data from photographer
    patch "/photographers/:slug" do
      @photographer = Photographer.find_by_slug(params[:slug])
      @photographer.update(:firstname => params[:firstname], :lastname => params[:lastname], :username => params[:username], :email => params[:email], :password => params[:password])
      redirect "/photographers"
    end
#open up the delete website for photographer
    get "/photographers/:slug/delete" do
      @photographer = Photographer.find_by_slug(params[:slug])
      erb :'photographers/delete'
    end
#accept the request from delete, and close out the session
    delete '/photographers/:slug' do
      if logged_in?
        @photographer = Photographer.find_by_slug(params[:slug])
        session.clear
        @photographer.delete
        redirect to '/'
      else
        redirect to '/login'
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
