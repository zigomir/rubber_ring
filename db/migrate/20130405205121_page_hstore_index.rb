class PageHstoreIndex < ActiveRecord::Migration
  def up
    add_index :pages, :controller
    add_index :pages, :action
    execute 'CREATE INDEX pages_gin_content ON pages USING GIN(content)'
  end

  def down
    remove_index :pages, :controller
    remove_index :pages, :action
    execute 'DROP INDEX pages_gin_content'
  end
end
