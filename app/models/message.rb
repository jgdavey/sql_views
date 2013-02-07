class Message < ActiveRecord::Base
  attr_accessible :body

  belongs_to :conversation
  belongs_to :user

  validates_presence_of :user, :conversation, :body
end
