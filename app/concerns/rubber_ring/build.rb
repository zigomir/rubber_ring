module RubberRing
  module Build

    def Build.assets!
      # clear old assets and copy new ones
      assets_dir = "#{Rails.root.to_s}/public/build/assets"
      unless File.directory?(assets_dir)
        FileUtils.mkdir_p(assets_dir)
      end

      FileUtils.rm_rf(assets_dir) if File.directory?(assets_dir)

      %w(images javascripts stylesheets).each do |asset_dir|
        FileUtils.cp_r("#{Rails.root.to_s}/app/assets/#{asset_dir}/.", assets_dir)
      end

      # copy attachments
      FileUtils.cp_r("#{Rails.root.to_s}/public/upload/", "#{Rails.root.to_s}/public/build")
    end

  end
end
