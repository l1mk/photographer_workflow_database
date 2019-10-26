require './config/environment'
#require 'pry'

class SessionsController < ApplicationController

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
            if !params[:firstname].empty? && !params[:lastname].empty? && !params[:email].empty?
              @client = Client.create(:firstname => params[:firstname], :lastname => params[:lastname], :email => params[:email])
              @session[:client_id] = @client.id
            else
              @session[:client_id] = (params[:client_id])
            end
          @session[:photographer_id] = current_user.id
          @session.save
          flash[:message] = "Successfully created a Session"
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
      @session = Session.find_by_id(params[:id])
      @client = @session.client
      @photographer = @session.photographer
      erb :"/sessions/show"
    end
#open up the editing form for the object
    get "/sessions/:id/edit" do
      @session = Session.find_by_id(params[:id])
      redirect_if_not_owner(@session.photographer)
        @clients = Client.all
        @photographers = Photographer.all
        erb :"/sessions/edit"
    end
#take params from edit to update the data of the object
    patch "/sessions/:id" do
      @session = Session.find_by_id(params[:id])
      if current_user == @session.photographer
      @session.update(:name => params[:name], :price => params[:price], :date => params[:date], :duration => params[:duration], :rating => params[:rating], :status => params[:status], :location => params[:location], :client_id => params[:client_id])
      flash[:message] = "Successfully updated a Session"
      end
      redirect "/sessions"
    end
#open up the delete website for client
    get "/sessions/:id/delete" do
      @session = Session.find_by_id(params[:id])
      redirect_if_not_owner(@session.photographer)
      erb :"sessions/delete"
    end
#accept the request from delete, and delete object
    delete '/sessions/:id' do
        @session = Session.find_by_id(params[:id])
        if current_user == @session.photographer
        @session.destroy
        flash[:message] = "Successfully delete the Session"
        end
      redirect to "/sessions"
    end
#Additional Methods for login authentication
    helpers do
      def redirect_if_not_owner(photographer)
        if current_user != photographer
          redirect "/sessions"
        end
      end
    end
#end of helper method
end
