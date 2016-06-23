class LikesController < ApplicationController
	def create
		secret = Secret.find(params['secret_id'])
		like = Like.create(user: current_user, secret: secret)
		redirect_to "/secrets"
	end

	def destroy
		# fail
		Like.find(params[:id]).destroy
		redirect_to "/secrets"
	end
end

