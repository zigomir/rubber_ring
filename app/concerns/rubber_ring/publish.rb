module RubberRing
  module Publish

    def Publish.assets!
      RRPublish::Sync.new('config/publish.yml').run
    end

  end
end
