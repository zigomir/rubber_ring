class AddLocaleToPage < ActiveRecord::Migration
  def change
    add_column :rubber_ring_pages, :locale, :string
  end
end
