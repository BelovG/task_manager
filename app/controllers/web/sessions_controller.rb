class Web::SessionsController < Web::ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user_tasks_path(user)
    else
      flash[:error] = t('controllers.web.sessions.create.flash.error')
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
