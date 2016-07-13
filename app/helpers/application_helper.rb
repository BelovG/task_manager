module ApplicationHelper
  def admin?
    current_user.admin?
  end

  def show_owner(task)
    task.user.present? ? task.user.email : "Не назначена"
  end
end
