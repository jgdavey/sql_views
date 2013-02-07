class InboxesController < ApplicationController
  expose(:user) { User.first }
  expose(:conversations) { user.conversations.includes(:messages) }

  def show
  end
end
