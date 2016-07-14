class Task < ActiveRecord::Base
  include AASM
  belongs_to :user
  validates :name, presence: true
  enum state: {New: 0, Started: 1, Finished: 2}
  mount_uploader :file, FileUploader

  aasm :column => :state, :enum => true do
    state :New, :initial => true
    state :Started
    state :Finished

    event :next_state do
      transitions :from => :New, :to => :Started
      transitions :from => :Started, :to => :Finished
    end
  end
end
