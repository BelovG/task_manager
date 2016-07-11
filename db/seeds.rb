admin = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
  user.password = Rails.application.secrets.admin_password
  user.role = 1
end
puts 'CREATED ADMIN USER: ' << admin.email

user = User.find_or_create_by!(email: Rails.application.secrets.user_email) do |user|
  user.password = Rails.application.secrets.user_password
end
puts 'CREATED USER: ' << user.email