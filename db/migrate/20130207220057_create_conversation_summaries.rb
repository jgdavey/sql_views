class CreateConversationSummaries < ActiveRecord::Migration
  def up
    execute <<-SQL.gsub(/ {6}/,'')
      CREATE VIEW conversation_summaries AS
        SELECT c.id,
        f.name as from_name,
        t.name as to_name,
        (select count(*) from messages m2 where m2.conversation_id = c.id) - 1 as reply_count
        FROM conversations c
        inner join users t on t.id = c.to_id
        inner join users f on f.id = c.from_id
    SQL
  end

  def down
    execute 'DROP VIEW conversation_summaries'
  end
end
