class InboxesController < ApplicationController
  expose(:user) { User.first }
  expose(:conversations) { user.conversations }

  def show
  end
end
