require 'rails_helper'

RSpec.describe Api::TasksController, type: :controller do
  before do
    @user = create(:user)
    sign_in(@user)
  end

  describe 'next_state action' do
    before do
      @task = create(:task)
    end

    it 'should change state' do
      put :next_state, user_id: @user.id, id: @task.id
      expect(@task.reload.state).to eq('Started')
    end
  end
end