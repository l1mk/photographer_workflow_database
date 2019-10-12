require './config/environment'
#require 'pry'
class ClientsController < Sinatra::Base
  #require configuration for sessions and password to work
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end
  #bring the index website of the object
    get "/clients" do
        @photographers = Photographer.all
        @sessions = Session.all
        @clients = Client.all
        erb :"/clients/index"
    end
#open up the form for the new client
    get "/clients/new" do
      if logged_in?
        erb :'/clients/new'
      else
        redirect "/login"
      end
    end
  #take form params from new to create new client under the current user
    post "/clients" do
      if logged_in?
        if !params[:firstname].empty? && !params[:lastname].empty? && !params[:status].empty? && !params[:email].empty? && !params[:rating].empty?
          @photographer = current_user
          @client = Client.new(:firstname => params[:firstname], :lastname => params[:lastname], :status => params[:status], :email => params[:email], :rating => params[:rating])
          @client.photographer = @photographer
          @client.save
          redirect "/clients"
        else
          redirect "/clients"
        end
      else
        redirect "/login"
      end
    end

  #open up the details page of the object
    get "/clients/:id" do
      @client = Client.find_by_id(params[:id])
      @sessions = Session.all
      @photographers = Photographer.all
      erb :"/clients/show"
    end
  #open up the editing form for the object
    get "/clients/:id/edit" do
      @client = Client.find_by_id(params[:id])
      @sessions = Session.all
      @photographers = Photographer.all
      erb :'/clients/edit'
    end
  #take params from edit to update the data of the object
    patch "/clients/:id" do
        @client = Client.find_by_id(params[:id])
      @client.update(:firstname => params[:firstname], :lastname => params[:lastname], :status => params[:status], :email => params[:email], :rating => params[:rating])
      redirect "/clients"
    end
  #open up the delete website for client
    get "/clients/:id/delete" do
      @client = Client.find_by_id(params[:id])
      erb :'clients/delete'
    end
  #accept the request from delete, and delete object
    delete '/client/:id' do
        @client = Client.find_by_id(params[:id])
        @client.delete
        redirect to '/'
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

end
