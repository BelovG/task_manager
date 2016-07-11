require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST create" do
    before do
      @user = create(:user)
    end

    it "success" do
      post :create, session: {email: @user.email, password: @user.password}
      expect(signed_in?).to eq(true)
    end

    it "fail" do
      post :create, session: {email: @user.email << "fail", password: @user.password << "fail"}
      expect(signed_in?).to eq(false)
    end
  end
end
