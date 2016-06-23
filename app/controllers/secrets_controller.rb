class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  # before_action :require_current_user, only: [:show, :edit, :update, :destroy]
  def index
  	@secrets = Secret.all
  	
  	# @secrets = Secret.all
  end
  def create
  	@secret = Secret.create(content: params[:new_secret], user: User.find(session[:id]))
  	unless @secret.errors.any?
  		redirect_to "/users/#{session[:id]}"
  	else
  		flash[:errors] = @secret.errors.full_messages
  		redirect_to "/users/#{session[:id]}"
  	end
  end

  def update
  end

  def destroy
  	Secret.find(params[:id]).destroy
  	# user = User.find(params[:id])
  	# user.secrets.destroy_all 
  	redirect_to "/users/#{session[:id]}"
  end

  private

  def secret_params
  	params.require(:secret).permit(:content, :user)
  end
end
