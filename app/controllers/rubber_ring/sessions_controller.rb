module RubberRing
  class SessionsController < ActionController::Base
    def new
    end

    def destroy
      session[:password] = nil

      # because main_app.root_path might not be defined
      redirect_to '/'
    end

    def create
      if params[:password] == RubberRing.admin_password
        session[:password] = params[:password]

        redirect_to '/'
      else
        flash.now[:error] = 'Wrong password'
        render :new
      end
    end
  end
end
