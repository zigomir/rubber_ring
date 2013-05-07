# This migration comes from rubber_ring (originally 20130507222546)
class AddLocaleToPage < ActiveRecord::Migration
  def change
    add_column :rubber_ring_pages, :locale, :string
  end
end
