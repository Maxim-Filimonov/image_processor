require 'pathname'

module ImageProcessor
  class Router
    attr_reader :root
    def initialize(args={})
      @root = Pathname.new(args.fetch(:root))
    end
    def image_index_path(opts={})
      create_path('/index.html', opts)
    end

    def make_path(make, opts={})
      create_path("/#{underscore(make)}/index.html", opts)
    end

    def model_path(make, model, opts={})
      create_path("/#{underscore(make)}/#{underscore(model)}.html", opts)
    end

    private
    def create_path(path, opts)
      if opts[:file_path]
        path
      else
        relative_path = root + Pathname.new("./#{path}")
        relative_path.to_path
      end
    end

    def underscore(value)
      value.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      tr(" ", "_").
      downcase
    end
  end
end
