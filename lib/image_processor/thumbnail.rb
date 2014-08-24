module ImageProcessor
  class Thumbnail
    attr_reader :model

    def initialize(model)
      @model = model
    end

    def url
      @model.urls[:medium]
    end
  end
end
