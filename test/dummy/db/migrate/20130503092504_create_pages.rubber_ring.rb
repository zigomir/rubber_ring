# This migration comes from rubber_ring (originally 20130405204838)
class CreatePages < ActiveRecord::Migration
  def change
    create_table :rubber_ring_pages do |t|
      t.string :controller
      t.string :action

      t.timestamps
    end
  end
end
