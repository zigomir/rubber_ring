class PageHstoreIndex < ActiveRecord::Migration
  def up
    add_index :rubber_ring_pages, [:controller, :action], :unique => true
    execute 'CREATE INDEX pages_gin_content ON rubber_ring_pages USING GIN(content)'
  end

  def down
    remove_index :rubber_ring_pages, :column => [:controller, :action]
    execute 'DROP INDEX pages_gin_content'
  end
end
