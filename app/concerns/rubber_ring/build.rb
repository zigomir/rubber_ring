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
      prod_assets_dir = "#{Rails.root.to_s}/public/assets"
      if Rails.env.production? and File.directory?(prod_assets_dir)
        FileUtils.cp_r("#{prod_assets_dir}/.", build_assets_dir)
      else
        %w(images javascripts stylesheets fonts).each do |asset_dir|
          FileUtils.cp_r("#{Rails.root.to_s}/app/assets/#{asset_dir}/.", build_assets_dir)
        end
      end

      # copy attachments
      upload_dir = "#{Rails.root.to_s}/public/upload"
      if File.directory?(upload_dir)
        FileUtils.cp_r(upload_dir, "#{Rails.root.to_s}/public/build")
      end
    end

  end
end
