require 'spec_helper'

describe User do
  describe "#conversations" do
    let!(:alice) { User.create(name: "Alice") }
    let!(:bob) { User.create(name: "Bob") }
    let!(:conversation) do
      Conversation.create(from_id: bob.id, to_id: alice.id, subject: "Hello")
    end

    it "includes sent conversations" do
      bob.conversations.should == [conversation]
    end

    it "includes received conversations" do
      alice.conversations.should == [conversation]
    end

    it "does not include conversations that are neither sent or received by the user" do
      conversation2 = Conversation.create(from_id: alice.id, to_id: alice.id, subject: "Hello")
      bob.conversations.should == [conversation]
      alice.conversations.should =~ [conversation, conversation2]
    end
  end
end
