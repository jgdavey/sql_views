class InboxesController < ApplicationController
  expose(:user) { User.first }
  expose(:conversations) { user.conversations.includes(:summary) }

  def show
  end
end
