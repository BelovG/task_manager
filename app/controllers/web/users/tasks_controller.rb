class Web::Users::TasksController < Web::Users::ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy, :download_file]

  def index
    @tasks = current_user.admin? ? Task.includes(:user) : current_user.tasks
  end

  def show
  end

  def edit
  end

  def update
    if user_exist? && @task.update(task_params)
      redirect_to user_task_path(@task.user, @task)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to user_tasks_path(current_user)
  end

  def download_file
    if @task.file.present?
      send_file(@task.file.path, disposition: 'attachment', url_based_filename: false)
    else
      render text: t('controllers.web.users.tasks.download_file.fail'), status: 404
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :file)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
    return if @task
    render text: t('controllers.web.users.tasks.find_task.fail'), status: 404
  end

  def user_exist?
    User.find(task_params[:user_id]).present?
  end
end
