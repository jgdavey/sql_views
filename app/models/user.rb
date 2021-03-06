class User < ActiveRecord::Base
  has_many :sent_conversations, class_name: "Conversation", foreign_key: 'from_id'
  has_many :received_conversations, class_name: "Conversation", foreign_key: 'to_id'

  attr_accessible :name
  validates_presence_of :name

  def conversations
    Conversation.where("? IN (from_id, to_id)", id)
  end
end
