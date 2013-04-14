module RubberRing
  module Build

    def Build.assets!
      # clear old assets and copy new ones
      %w(images javascripts stylesheets).each do |asset_dir|
        FileUtils.rm_rf("#{Rails.root.to_s}/public/build/#{asset_dir}/")
        FileUtils.cp_r("#{Rails.root.to_s}/public/#{asset_dir}/", "#{Rails.root.to_s}/public/build")
      end
    end

  end
end
