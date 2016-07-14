class Web::Users::TasksController < Web::Users::ApplicationController
  respond_to :html, :json
  before_action :find_task, only: [:show, :edit, :update, :destroy, :download_file, :change_state]

  def index
    @tasks = current_user.admin? ? Task.includes(:user) : current_user.tasks
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to user_task_path(@task.user, @task) }
        format.json { render json: { status: '200' } }
      else
        format.html { render 'edit' }
        format.json { render json: { errors: @task.errors, status: '500' } }
      end
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
      render text: 'Страница не найдена', status: 404
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :state, :file)
  end

  def find_task
    @task = Task.find_by_id(params[:id])
    return if @task
    render text: 'Страница не найдена', status: 404
  end
end
