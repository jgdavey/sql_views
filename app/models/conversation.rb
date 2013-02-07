class Conversation < ActiveRecord::Base
  belongs_to :to, class_name: "User"
  belongs_to :from, class_name: "User"
  has_many :messages, dependent: :destroy, inverse_of: :conversation

  attr_accessible :from_id, :to_id, :subject
  validates_presence_of :from_id, :to_id, :subject

  def most_recent_message_body
    most_recent_message.body if most_recent_message
  end

  def most_recent_message_sent_at
    most_recent_message.created_at if most_recent_message
  end

  def reply_count
    [messages.size - 1, 0].max
  end

  def to_name
    to.name
  end

  def from_name
    from.name
  end

  private
  def most_recent_message
    @most_recent_message ||= messages.by_date.first
  end
end
