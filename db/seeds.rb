cat = User.find_or_create_by_name "Cat Stevens"
felionel  = User.find_or_create_by_name "Felionel Richie"
nelly  = User.find_or_create_by_name "Nelly Purrtado"

Conversation.destroy_all

Conversation.create! do |c|
  c.from = felionel
  c.to = cat
  c.subject = "Hello. Is it me you're looking fur?"

  c.messages.build do |m|
    m.user = felionel
    m.body = "I think I may be the cat you're looking for."
    m.created_at = 2.days.ago
  end

  c.messages.build do |m|
    m.user = cat
    m.body = "Wow. I really don't know how to respond to that."
    m.created_at = 20.hours.ago
  end

  c.messages.build do |m|
    m.user = felionel
    m.body = "Say you. Say meow."
    m.created_at = 14.hours.ago
  end
end

Conversation.create! do |c|
  c.from = nelly
  c.to = cat
  c.subject = "I'm like a bird"

  c.messages.build do |m|
    m.user = nelly
    m.body = "Except that I'm a cat"
    m.created_at = 3.days.ago
  end
end

Conversation.create! do |c|
  c.from = cat
  c.to = felionel
  c.subject = "Another Caturday Night"

  c.messages.build do |m|
    m.user = cat
    m.body = "And I ain't got nobody"
    m.created_at = 12.days.ago
  end

  c.messages.build do |m|
    m.user = felionel
    m.body = "I'm sorry that you're feeling that way"
    m.created_at = 9.days.ago
  end
end
