class Web::ProfilesController < Web::ApplicationController
  def show
    @tasks = current_user.admin? ? Task.includes(:user) : current_user.tasks
  end
end
