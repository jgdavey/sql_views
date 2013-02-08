class InboxesController < ApplicationController
  expose(:user) { User.first }
  expose(:conversations) { user.conversations.most_recent }

  def show
  end
end
