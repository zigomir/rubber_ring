module RubberRing
  class SessionsController < ActionController::Base
    def new

    end

    def create
      session[:password] = params[:password]
      redirect_to main_app.root_path
    end
  end
end
