require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "index action" do
    it "renders index templat" do
      get :index
      expect(response).to render_template('index')
    end

    it "array of tasks" do
      task = create(:task)
      get :index
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe "new action" do
    it "initializes task" do
      get :new
      expect(assigns(:task).present?).to eq(true)
    end

    it "renders the :new view" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "create action" do
    context "with valid attributes" do
      it "creates a new task" do
        expect{
          post :create, task: attributes_for(:task)
        }.to change(Task,:count).by(1)
      end

      it "redirects to task_path" do
        post :create, task: attributes_for(:task)
        expect(response).to redirect_to(task_path(Task.last))
      end
    end

    context "with invalid attributes" do
      it "does not save the new task" do
        expect{
          post :create, task: attributes_for(:task, name: nil)
        }.to_not change(Task,:count)
      end

      it "renders new page" do
        post :create, task: attributes_for(:task, name: nil)
        expect(response).to render_template('new')
      end
    end
  end


  describe "show action" do
    context "task found" do
      before { @task = create(:task) }

      it "renders show template if an task found" do
        get :show, {id: @task.id}
        expect(response).to render_template(:show)
      end

      it "assigns the requested task" do
        get :show, id: @task.id
        expect(assigns(:task)).to eq(@task)
      end
    end

    context "task is not found" do
      it "renders 404 page if an task is not found" do
        get :show, id: "0"
        expect(response.status).to eq(404)
      end
    end
  end

  describe "edit action" do
    context "task found" do
      before { @task = create(:task) }

      it "renders show template if an task found" do
        get :edit, {id: @task.id}
        expect(response).to render_template(:edit)
      end

      it "assigns the requested task" do
        get :edit, id: @task.id
        expect(assigns(:task)).to eq(@task)
      end
    end

    context "task is not found" do
      it "renders 404 page if an task is not found" do
        get :edit, id: "0"
        expect(response.status).to eq(404)
      end
    end
  end

  describe "update action" do
    before { @task = create(:task) }

    context "with valid attributes" do
      it "update task" do

        put :update, {task: {name: "test"}, id: @task.id}
        expect(@task.reload.name).to eq("test")
      end
    end

    context "with invalid attributes" do
      it "renders edit page" do
        put :update, {task: {name: ""}, id: @task.id}
        expect(response).to render_template('edit')
      end
    end
  end

  describe "destroy action" do
    before do
      sign_in(create(:user))
      @task = create(:task)
    end

    it "delete task" do
      delete :destroy, { id: @task.id }
      expect(Task.count).to eq(0)
    end
  end
end
