cat = User.find_or_create_by_name "Cat Stevens"
felionel  = User.find_or_create_by_name "Felionel Richie"
nelly  = User.find_or_create_by_name "Nelly Purrtado"

Message.delete_all
Conversation.delete_all

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

if ENV["ITERATIONS"].present?
  dates = 28.times.map { |i| i.days.ago.strftime("%Y-%m-%d") }
  times = 24.times.map { |i| "%02d:00:00" % i }
  user_ids = User.pluck(:id)
  connection = ActiveRecord::Base.connection
  amounts = [3,5,9,10,14,28]
  dot = "."

  iterations = ENV["ITERATIONS"].to_i

  from = user_ids.sample

  puts "Creating conversations"

  ids = iterations.times.map do |i|
    print dot if i % 100 == 0
    to = (user_ids - [from]).sample
    subject = "Iterated message #{i}"
    result = connection.execute <<-SQL
      INSERT INTO conversations(from_id, to_id, subject, created_at, updated_at)
      VALUES (#{from}, #{to}, '#{subject}', now(), now())
      RETURNING id
    SQL
    result.first["id"]
  end


  statements = ids.map do |id|
    values = amounts.sample.times.map do |j|
      body = "Generated message #{id} - #{j}"
      created_at = "#{dates[j]} #{times.sample}"
      "(#{id}, #{user_ids.sample}, '#{body}', '#{created_at}', now())"
    end

    "INSERT INTO messages(conversation_id, user_id, body, created_at, updated_at) VALUES #{values.join(", ")}"
  end

  puts "\n\nCreating messages"

  statements.in_groups_of(250, false) do |group|
    print dot

    connection.execute "BEGIN"
    connection.execute group.join("; ")
    connection.execute "COMMIT"
  end

  puts
end
