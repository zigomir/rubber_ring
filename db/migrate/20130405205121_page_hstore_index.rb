class PageHstoreIndex < ActiveRecord::Migration
  def up
    add_index :pages, [:controller, :action], :unique => true
    execute 'CREATE INDEX pages_gin_content ON pages USING GIN(content)'
  end

  def down
    remove_index :pages, :column => [:controller, :action]
    execute 'DROP INDEX pages_gin_content'
  end
end
