module ImageProcessor
  module Routes
    def self.image_index_path
      '/index.html'
    end

    def self.make_path(make)
      "/#{make.downcase}/index.html"
    end

    def self.model_path(make, model)
      "/#{make.downcase}/#{model.downcase}.html"
    end
    
  end
end
