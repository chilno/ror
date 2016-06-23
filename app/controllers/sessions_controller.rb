class SessionsController < ApplicationController
  def index
  end

  def new

  end

  def create
  	@user = User.find_by(email: params[:email])
  	if @user and @user.authenticate(params[:password])
  	  session[:id] = @user.id
  	  redirect_to "/users/#{session[:id]}"
  	else
  	  flash[:notice] = "Invalid"
  	  redirect_to '/login'
  	end
  end

  def destroy
      session.clear
	  redirect_to '/login'
  end
end
