class CreateConversationSummaries < ActiveRecord::Migration
  def up
    execute <<-SQL.gsub(/ {6}/,'')
      CREATE VIEW conversation_summaries AS
        SELECT c.id,
        f.name as from_name,
        t.name as to_name,
        m.body as most_recent_message_body,
        m.created_at as most_recent_message_sent_at,
        (select count(*) from messages m2 where m2.conversation_id = c.id) - 1 as reply_count
        FROM conversations c
        inner join users t on t.id = c.to_id
        inner join users f on f.id = c.from_id
        left outer join (
          select distinct on(conversation_id) conversation_id, body, created_at
          from messages m1
          order by conversation_id, created_at desc
        ) m ON m.conversation_id = c.id
    SQL
  end

  def down
    execute 'DROP VIEW conversation_summaries'
  end
end
