class CreateRubberRingPageTemplates < ActiveRecord::Migration
  def change
    create_table :rubber_ring_page_templates do |t|
      t.string :key
      t.string :template
      t.string :element
      t.string :tclass
      t.integer :index
      t.integer :sort
      t.references :page, index: true

      t.timestamps
    end
  end
end
