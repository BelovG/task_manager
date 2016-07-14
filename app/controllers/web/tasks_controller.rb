class Web::TasksController < Web::ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)

    if @task.persisted?
      redirect_to user_task_path(params[:task][:user_id], @task)
    else
      render 'new'
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :state, :file)
  end
end