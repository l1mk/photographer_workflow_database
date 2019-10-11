require './config/environment'

class PhotographersController < Sinatra::Base

    post "/signup" do
      if !params[:username].empty? && !params[:email].empty? && !params[:password].empty? && !params[:firstname].empty? && !params[:lastname].empty?
        @photographer = Photographer.new(:firstname => params[:firstname], :lastname => params[:lastname], :username => params[:username], :email => params[:email], :password => params[:password])
          if @photographer.save
            session[:photographer_id] = @photographer.id
            redirect "/welcome"
          else
            redirect "/signup"
          end
      else
        redirect "/signup"
      end
    end

    post "/login" do
        @photographer = Photographer.find_by(:username => params[:username])
        if @photographer && @photographer.authenticate(params[:password])
          session[:photographer_id] = @photographer.id
          redirect "/welcome"
        else
          redirect "/login"
        end
    end

    get "/photographers/:slug" do
      @photographer = Photographer.find_by_slug(params[:slug])
      erb :"/photographers/show"
    end



end
