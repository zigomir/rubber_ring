module RubberRing
  module Build

    def Build.assets!
      # clear old assets and copy new ones
      build_assets_dir = "#{Rails.root.to_s}/public/build/assets"
      if File.directory?(build_assets_dir)
        FileUtils.rm_rf("#{build_assets_dir}/*")
      else
        FileUtils.mkdir_p(build_assets_dir)
      end

      # if running on production copy assets from precompiled files from public directory
      if Rails.env.production?
        FileUtils.cp_r("#{Rails.root.to_s}/public/assets/.", build_assets_dir)
      else
        %w(images javascripts stylesheets fonts).each do |asset_dir|
          FileUtils.cp_r("#{Rails.root.to_s}/app/assets/#{asset_dir}/.", build_assets_dir)
        end
      end

      # copy attachments
      FileUtils.cp_r("#{Rails.root.to_s}/public/upload", "#{Rails.root.to_s}/public/build")
    end

  end
end
