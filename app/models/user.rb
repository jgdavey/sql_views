class User < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name

  has_many :sent_conversations, class_name: "Conversation", foreign_key: 'from_id'
  has_many :received_conversations, class_name: "Conversation", foreign_key: 'to_id'
end
