class Api::TasksController < Api::ApplicationController
  before_action :find_task, only: :next_state

  def next_state
    if @task.next_state!
      render json: { state: @task.state, status: 200 }
    else
      render json: { state: @task.state, status: 500 }
    end
  end

  private

  def find_task
    @task = Task.find_by_id(params[:id])
    return if @task
    render text: 'Задача не найдена', status: 404
  end
end