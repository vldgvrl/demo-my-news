class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "Kirjautuminen onnistui"
            redirect_to root_path
        else
            flash.now[:danger] = "Ei onnistui, kokeilla uudestaan"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "Olet kirjautunut ulos"
        redirect_to root_path
    end

end
