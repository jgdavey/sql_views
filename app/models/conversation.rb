class Conversation < ActiveRecord::Base
  belongs_to :to, class_name: "User"
  belongs_to :from, class_name: "User"

  attr_accessible :from_id, :to_id, :subject
  validates_presence_of :from_id, :to_id, :subject
end
