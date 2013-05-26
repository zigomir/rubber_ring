# This migration comes from rubber_ring (originally 20130520170604)
class CreateRubberRingPageTemplates < ActiveRecord::Migration
  def change
    create_table :rubber_ring_page_templates do |t|
      t.string :key
      t.string :template
      t.string :element
      t.string :tclass
      t.integer :sort
      t.references :page, index: true

      t.timestamps
    end
  end
end
