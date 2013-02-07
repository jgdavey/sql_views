class Conversation < ActiveRecord::Base
  class Summary < ActiveRecord::Base
    self.table_name = "conversation_summaries"
    self.primary_key = "id"
    belongs_to :conversation, foreign_key: "id"
    belongs_to :most_recent_message, class_name: "Message"
  end

  belongs_to :to, class_name: "User"
  belongs_to :from, class_name: "User"
  has_many :messages, dependent: :destroy, inverse_of: :conversation
  has_one :summary, foreign_key: "id"

  attr_accessible :from_id, :to_id, :subject
  validates_presence_of :from_id, :to_id, :subject

  delegate :to_name, :from_name, :most_recent_message, to: :summary

  def most_recent_message_body
    most_recent_message.body if most_recent_message
  end

  def most_recent_message_sent_at
    most_recent_message.created_at if most_recent_message
  end

  def reply_count
    [summary.reply_count, 0].max
  end

end
