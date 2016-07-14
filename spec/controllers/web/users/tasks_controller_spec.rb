require 'rails_helper'

RSpec.describe Web::Users::TasksController, type: :controller do
  before do
    @user = create(:user)
    sign_in(@user)
  end

  describe 'index action' do
    before do
      create(:task)
    end

    it 'renders show template' do
      get :index, user_id: @user.id
      expect(response).to render_template(:index)
    end
  end

  describe 'show action' do
    context 'task found' do
      before { @task = create(:task) }

      it 'renders show template if an task found' do
        get :show, id: @task.id, user_id: @user.id
        expect(response).to render_template(:show)
      end

      it 'assigns the requested task' do
        get :show, id: @task.id, user_id: @user.id
        expect(assigns(:task)).to eq(@task)
      end
    end

    context 'task is not found' do
      it 'renders 404 page if an task is not found' do
        get :show, id: 0, user_id: @user.id
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'edit action' do
    context 'task found' do
      before { @task = create(:task) }

      it 'renders show template if an task found' do
        get :edit, id: @task.id, user_id: @user.id
        expect(response).to render_template(:edit)
      end

      it 'assigns the requested task' do
        get :edit, id: @task.id, user_id: @user.id
        expect(assigns(:task)).to eq(@task)
      end
    end

    context 'task is not found' do
      it 'renders 404 page if an task is not found' do
        get :edit, id: 0, user_id: @user.id
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'update action' do
    before { @task = create(:task) }

    context 'with valid attributes' do
      it 'update task' do
        put :update, task: { name: 'test' }, id: @task.id, user_id: @user.id
        expect(@task.reload.name).to eq('test')
      end
    end

    context 'with invalid attributes' do
      it 'renders edit page' do
        put :update, task: { name: '' }, id: @task.id, user_id: @user.id
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'destroy action' do
    before do
      sign_in(create(:user))
      @task = create(:task)
    end

    it 'delete task' do
      delete :destroy, id: @task.id, user_id: @user.id
      expect(Task.count).to eq(0)
    end
  end

  describe 'download_file action' do
    context 'task found' do
      before do
        @task = create(:task)
        @task_with_file = create(:task_with_file)
      end

      it 'renders 404 page if an file is not found' do
        post :download_file, id: @task.id, user_id: @user.id
        expect(response.status).to eq(404)
      end

      it 'download if an file is found' do
        post :download_file, id: @task_with_file.id, user_id: @user.id
        res = "attachment; filename=\"#{@task_with_file.file.get_filename}\""
        expect(response.header['Content-Disposition']).to eq(res)
      end
    end

    context 'task is not found' do
      it 'renders 404 page if an task is not found' do
        post :download_file, id: 0, user_id: @user.id
        expect(response.status).to eq(404)
      end
    end
  end
end
