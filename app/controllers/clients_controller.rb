require './config/environment'

class ClientsController < ApplicationController
#bring the index website of the object
    get "/clients" do
        @photographers = Photographer.all
        @sessions = Session.all
        @clients = Client.all
        @success_message = session[:success_message]
        session[:success_message] = nil
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
        if !params[:firstname].empty? && !params[:lastname].empty? && !params[:email].empty?
          @client = Client.new(:firstname => params[:firstname], :lastname => params[:lastname], :email => params[:email])
          @client.save
          flash[:message] = "Successfully created new Client."
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
      @client.update(:firstname => params[:firstname], :lastname => params[:lastname], :email => params[:email])
      flash[:message] = "Successfully updated Client"
      redirect "/clients"
    end
#open up the delete website for client
    get "/clients/:id/delete" do
      @client = Client.find_by_id(params[:id])
      erb :'clients/delete'
    end
#accept the request from delete, and delete object
    delete '/clients/:id' do
      @client = Client.find_by_id(params[:id])
      @client.delete
      flash[:message] = "Successfully deleted the Client"
      redirect to '/clients'
    end
end
