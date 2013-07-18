module RubberRing
  class PageContent < ActiveRecord::Base
    attr_accessible :key, :value, :page
    belongs_to :page
  end
end
