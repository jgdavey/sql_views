class InboxesController < ApplicationController
  expose(:user) { User.first }
  expose(:conversations) { user.conversations.includes(summary: :most_recent_message) }

  def show
  end
end
