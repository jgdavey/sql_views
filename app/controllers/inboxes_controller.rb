class InboxesController < ApplicationController
  expose(:user) { User.first }
  expose(:conversations) { user.conversations.includes(:messages, :to, :from) }

  def show
  end
end
