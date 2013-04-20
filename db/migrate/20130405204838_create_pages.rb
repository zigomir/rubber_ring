class CreatePages < ActiveRecord::Migration
  def change
    create_table :rubber_ring_pages do |t|
      t.string :controller
      t.string :action
      t.hstore :content

      t.timestamps
    end
  end
end
