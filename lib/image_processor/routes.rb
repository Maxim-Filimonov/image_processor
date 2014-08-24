module ImageProcessor
  module Routes
    def self.image_index_path
      '/index.html'
    end

    def self.make_path(make)
      "/#{underscore(make)}/index.html"
    end

    def self.model_path(make, model)
      "/#{underscore(make)}/#{underscore(model)}.html"
    end

    def self.underscore(value)
      value.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      tr(" ", "_").
      downcase
    end
  end
end
