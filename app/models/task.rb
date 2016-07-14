class Task < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  enum state: %w(New Started Finished)
  mount_uploader :file, FileUploader
end
