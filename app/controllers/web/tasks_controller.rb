class Web::TasksController < Web::ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if user_exist? && @task.save
      redirect_to user_task_path(@task.user_id, @task)
    else
      render 'new'
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id,  :file)
  end

  def user_exist?
    User.find(task_params[:user_id]).present?
  end
end