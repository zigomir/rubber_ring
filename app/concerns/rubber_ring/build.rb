module RubberRing
  module Build

    def Build.run!(request)
      # wget -m -p -E -k -np http://localhost:3000 -P build -nH
      # -nH: no host directories
      # -p: prefix with directory
      # -E: adjust extension, save as .html
      # -k: convert links suitable for local viewing

      root_url = request.protocol + request.host_with_port
      build_dir = "#{Rails.root.to_s}/public/build"

      # clear previous build
      FileUtils.rm_rf(build_dir)

      cmd = "wget -m -p -E -k -np #{root_url} -P #{build_dir} -nH"
      thread = Thread.new do
        system(cmd)
      end
      thread
    end

  end
end
