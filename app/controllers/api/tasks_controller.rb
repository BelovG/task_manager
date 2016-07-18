class Api::TasksController < Api::ApplicationController
  before_action :find_task, only: :next_state

  def next_state
    if @task.next_state!
      render json: @task.as_json
    else
      render json: @task.as_json
    end
  end

  private

  def find_task
    @task = Task.find_by(id: params[:id])
    return if @task
    render text: t('controllers.api.tasks.fail'), status: 404
  end
end