require 'fileutils'
module ImageProcessor
  class OutputWriter
    attr_reader :render, :out_dir

    def initialize(render, args={})
      @render = render
      @out_dir = args.fetch(:out_dir)
    end

    def write
      if File.exists?(out_dir)
        FileUtils.rm_r(out_dir)
      end
      write_index if render[:index]
      write_makes if render[:makes]
      write_models if render[:models]
    end

    private
    def write_index
      write_file('index.html', render[:index])
    end

    def write_makes
      render[:makes].each do |path, content|
        write_file(path, content)
      end
    end

    def write_models
      render[:models].each do |path, content|
        write_file(path, content)
      end
    end

    def write_file(path, content)
      file_path = File.join(out_dir, path)
      FileUtils.mkdir_p(File.dirname(file_path))
      File.open(file_path, 'w') do |f|
        f.write(content)
      end
    end
  end
end
