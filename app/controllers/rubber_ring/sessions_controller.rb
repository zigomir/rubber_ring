module RubberRing
  class SessionsController < ActionController::Base
    def new
    end

    def destroy
      session[:password] = nil
      redirect_to main_app.root_path
    end

    def create
      if params[:password] == RubberRing.admin_password
        session[:password] = params[:password]
        redirect_to main_app.root_path
      else
        flash.now[:error] = 'Wrong password'
        render :new
      end
    end
  end
end
