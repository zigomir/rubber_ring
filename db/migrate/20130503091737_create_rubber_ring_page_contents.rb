class CreateRubberRingPageContents < ActiveRecord::Migration
  def change
    create_table :rubber_ring_page_contents do |t|
      t.string :key
      t.string :value
      t.references :page, index: true

      t.timestamps
    end
  end
end
