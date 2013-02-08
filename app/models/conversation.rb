class Conversation < ActiveRecord::Base
  class Summary < ActiveRecord::Base
    self.table_name = "conversation_summaries"
    self.primary_key = "id"
    belongs_to :conversation, foreign_key: "id"
    scope :most_recent_first, order("#{table_name}.most_recent_message_sent_at desc")
  end

  belongs_to :to, class_name: "User"
  belongs_to :from, class_name: "User"
  has_many :messages, dependent: :destroy, inverse_of: :conversation
  has_one :summary, foreign_key: "id"

  attr_accessible :from_id, :to_id, :subject
  validates_presence_of :from_id, :to_id, :subject

  delegate :to_name, :from_name, :most_recent_message_sent_at, :most_recent_message_body, to: :summary

  def self.most_recent
    includes(:summary).merge(Summary.most_recent_first)
  end

  def reply_count
    [summary.reply_count, 0].max
  end

end
