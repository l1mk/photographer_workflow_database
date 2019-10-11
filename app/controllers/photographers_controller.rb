require './config/environment'
#require 'pry'
class PhotographersController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/photographers" do
    if logged_in?
      @photographer = Photographer.find_by_id(session[:photographer_id])
      @sessions = Session.all
      @clients = Client.all
      erb :"/photographers/welcome"
    else
      redirect "/login"
    end
  end

    post "/signup" do
#binding.pry
      #if !params[:firstname].empty? && !params[:lastname].empty? && !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
        @photographer = Photographer.new(:firstname => params[:firstname], :lastname => params[:lastname], :username => params[:username], :email => params[:email], :password => params[:password])
          if @photographer.save
            session[:photographer_id] = @photographer.id
            redirect "/photographers"
          else
            redirect "/signup"
          end
      #else
        #redirect "/signup"
      #end
    end

    post "/login" do
        @photographer = Photographer.find_by(:username => params[:username])
        if @photographer && @photographer.authenticate(params[:password])
          session[:photographer_id] = @photographer.id
          redirect "/photographers"
        else
          redirect "/login"
        end
    end

    get "/photographers/:slug" do
      @photographer = Photographer.find_by_slug(params[:slug])
      erb :"/photographers/show"
    end

    get "/photographers/:slug/edit" do
      @photographer = Photographer.find_by_slug(params[:slug])
      @sessions = Session.all
      @clients = Client.all
      erb :'photographers/edit'
    end

 patch '/photographers/:slug' do

   #if !params[:photographer].keys.include?("clients")
   #params[:photographers]["clients"] = []
   #end

   @photographer = Photographer.find_by_slug(params[:slug])
   @photographer.update(params["photographer"])

     #if !params["session"]["type"].empty? && !params["session"]["price"].empty? && !params["session"]["date"].empty?
    #   if @session = Session.find_by(date: params["session"]["date"])
    #   @photographer.session = @session
    #   @photographer.save
    #   else
    #   @photographer.session = Session.create(type: params["session"]["type"], price: params["session"]["price"], date: params["session"]["date"])
    #   @photographer.save
    #   end
     #else params["session"]["type"] == ""
    #   @photographer.session = nil
    #   @photographer.save
     #end
     #  if !params["artist"]["name"].empty?
     #  @song.artist = Artist.create(name: params["artist"]["name"])
     #  @song.save
     #elsif params["artist"]["name"] == ""
     #  @song.artist = nil
     #  @song.save
     #elsif  @artist = Artist.find(params["artist"]["name"])
     #  @song.artist = @artist
     #  @song.save

   redirect to "/photographers/#{@photographer.slug}"
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
