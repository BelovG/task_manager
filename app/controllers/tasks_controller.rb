class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def show
  end

  def edit
  end

  def create
    @task = Task.create(task_params)

    if @task.persisted?
      redirect_to task_path(@task)
    else
      render 'new'
    end
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to user_profile_path(current_user)
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :user_id)
  end

  def find_task
    @task = Task.find_by_id(params[:id])
    unless @task
      render text: "Страница не найдена", status: 404
    end
  end
end
