class Message < ActiveRecord::Base
  attr_accessible :body, :user_id

  belongs_to :conversation, inverse_of: :messages
  belongs_to :user

  validates_presence_of :user, :conversation, :body

  def self.by_date
    order("created_at DESC")
  end
end
