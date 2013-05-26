# This migration comes from rubber_ring (originally 20130520170602)
class CreatePages < ActiveRecord::Migration
  def change
    create_table :rubber_ring_pages do |t|
      t.string :controller
      t.string :action
      t.string :locale

      t.timestamps
    end
  end
end
