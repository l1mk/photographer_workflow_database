require './config/environment'
require 'pry'

class SessionsController < Sinatra::Base
#require configuration for sessions and password to work
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end
#bring the index website of the object
    get "/sessions" do
        @photographers = Photographer.all
        @sessions = Session.all
        @clients = Client.all
      erb :"/sessions/index"
    end
#open up the form for the new client
    get "/sessions/new" do
      if logged_in?
        @clients = Client.all
        erb :"/sessions/new"
      else
        redirect "/login"
      end
    end
#take form params from new to create new client under the current user
    post "/sessions" do
      if logged_in?
        if !params[:name].empty? && !params[:price].empty? && !params[:date].empty? && !params[:duration].empty? && !params[:rating].empty? && !params[:status].empty? && !params[:location].empty?
          @session = Session.new(:name => params[:name], :price => params[:price], :date => params[:date], :duration => params[:duration], :rating => params[:rating], :status => params[:status], :location => params[:location])
          @client = Client.create(:firstname => params[:firstname], :lastname => params[:lastname], :email => params[:email])
          @clients.all
          @session[:client_id] = @clients.last.id
          @session[:photographer_id] = current_user.id
          @session.save
          redirect "/sessions"
        else
          redirect "/sessions"
        end
      else
        redirect "/login"
      end
    end

#open up the details page of the object
    get "/sessions/:id" do
      binding.pry
      @session = Session.find_by_id(params[:id])
      @client = Client.find_by_id(@session.client_id)
      @photographer = Photographer.find_by_id(@session.photographer_id)
      erb :"/sessions/show"
    end
#open up the editing form for the object
    get "/sessions/:id/edit" do
      @session = Session.find_by_id(params[:id])
      @clients = Client.all
      @photographers = Photographer.all
      erb :"/sessions/edit"
    end
#take params from edit to update the data of the object
    patch "/sessions/:id" do
      @session = Session.find_by_id(params[:id])
      @session.update(:name => params[:name], :price => params[:price], :date => params[:date], :duration => params[:duration], :rating => params[:rating], :status => params[:status], :location => params[:location], :photographer_id => current_user.id)
      @clients = Client.all
      @session[:client_id] = @clients.last.id
    redirect "/sessions"
    end
#open up the delete website for client
    get "/sessions/:id/delete" do
      @session = Session.find_by_id(params[:id])
      erb :"sessions/delete"
    end
#accept the request from delete, and delete object
    delete '/sessions/:id' do
        @session = Session.find_by_id(params[:id])
        @session.destroy
      redirect to "/sessions"
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
