require 'spec_helper'

describe Conversation do
  let(:alice) { User.create(name: "Alice") }
  let(:bob) { User.create(name: "Bob") }
  let(:conversation) do
    Conversation.create(from_id: bob.id, to_id: alice.id, subject: "Hello")
  end

  describe "#most_recent_message_body" do
    it "returns the most recent message's body" do
      conversation.messages.create(user_id: bob.id, body: "First")
      conversation.messages.create(user_id: alice.id, body: "Second")
      conversation.messages.create(user_id: bob.id, body: "Third")

      conversation.most_recent_message_body.should == "Third"
    end

    it "returns nil when there are no recent messages" do
      conversation.most_recent_message_body.should be_nil
    end
  end

  describe "#most_recent_message_sent_at" do
    it "returns the most recent message's body" do
      m1 = conversation.messages.create(user_id: bob.id, body: "First")
      m2 = conversation.messages.create(user_id: alice.id, body: "Second")
      m3 = conversation.messages.create(user_id: bob.id, body: "Third")

      conversation.most_recent_message_sent_at.should == m3.created_at
    end

    it "returns nil when there are no recent messages" do
      conversation.most_recent_message_sent_at.should be_nil
    end
  end

  describe "#reply_count" do
    it "returns the number of replies to the original message" do
      conversation.reply_count.should == 0

      conversation.messages.create(user_id: bob.id, body: "First")
      conversation.reply_count.should == 0

      conversation.messages.create(user_id: alice.id, body: "Second")
      conversation.reply_count.should == 1
    end
  end
end
