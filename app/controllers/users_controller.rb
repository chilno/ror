class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	def show
		if session[:id]
			@user = User.find(params[:id])
		else
			render text: 'Get the fuck outta here!'
		end
	end

	def create
		@user = User.create(user_params)
		unless @user.errors.any?
			session[:id] = @user.id
			redirect_to "/users/#{session[:id]}"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to "/users/new"
		end

	end

	def edit
		@user = User.find(session[:id])
	end

	def update
		@user = User.find(session[:id])
		@user.update(user_params)
		unless @user.errors.any?
			redirect_to "/users/#{session[:id]}"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to "/users/#{session[:id]}/edit"
		end
	end

	def destroy
		User.find(session[:id]).destroy
		session.clear
		redirect_to '/sessions/new'
	end

	private

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end

end
