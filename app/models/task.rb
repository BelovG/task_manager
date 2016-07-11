class Task < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name
  enum state: ['New', 'Started', 'Finished']
end
