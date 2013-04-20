module RubberRing
  module Build

    # TODO read upload/build dir from settings
    def Build.assets!
      # clear old assets and copy new ones
      assets_dir = "#{Rails.root.to_s}/public/build/assets"
      FileUtils.rm_rf(assets_dir) if File.directory?(assets_dir)

      %w(images javascripts stylesheets).each do |asset_dir|
        FileUtils.cp_r("#{Rails.root.to_s}/app/assets/#{asset_dir}/.", assets_dir)
      end

      # copy uploaded images
      FileUtils.cp_r("#{Rails.root.to_s}/public/images/", "#{Rails.root.to_s}/public/build")
    end

  end
end
