require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
    @secret = Secret.create(user: @user, content: "secret")
    @like = Like.create(user: @user, secret: @secret)
  end
  describe "when not logged in" do
    before do
    	session[:id] = nil
    end
    it "cannot access create" do
    	post :create
    	expcect(response).to redirect_to('/sessions/new')
    end
    it "cannot access destroy" do
    	delete :destroy, like: @like
    	expcect(response).to redirect_to('/sessions/new')
    end
  end
end
