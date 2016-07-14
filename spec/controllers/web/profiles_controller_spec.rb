require 'rails_helper'

RSpec.describe Web::ProfilesController, type: :controller do
  describe "show action" do
    before do
      create(:task)
      @user = create(:user)
      sign_in(@user)
    end

    it "renders show template" do
      get :show, {user_id: @user.id}
      expect(response).to render_template(:show)
    end
  end
end
