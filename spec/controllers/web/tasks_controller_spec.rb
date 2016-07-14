require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do

  describe 'index action' do
    it 'renders index templat' do
      get :index
      expect(response).to render_template('index')
    end

    it 'array of tasks' do
      task = create(:task)
      get :index
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe 'new action' do
    it 'initializes task' do
      get :new
      expect(assigns(:task).present?).to eq(true)
    end

    it 'renders the :new view' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'create action' do
    before { create(:user) }

    context 'with valid attributes' do
      it 'creates a new task' do
        expect { post :create, task: attributes_for(:task) }.to change(Task, :count).by(1)
      end

      it 'redirects to task_path' do
        post :create, task: attributes_for(:task)
        task = Task.last
        expect(response).to redirect_to(user_task_path(task.user_id, task))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new task' do
        expect { post :create, task: attributes_for(:task, name: nil) }.to_not change(Task, :count)
      end

      it 'renders new page' do
        post :create, task: attributes_for(:task, name: nil)
        expect(response).to render_template('new')
      end
    end
  end
end