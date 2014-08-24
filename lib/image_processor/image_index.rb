require 'image_processor/make'
module ImageProcessor
  class ImageIndex
    attr_reader :makes

    def initialize
      @makes = {}
    end

    def add_make(name)
      makes[name] ||= Make.new(name: name)
      makes[name]
    end

    def all_models
      makes.map {|k,v| v.all_models }.flatten
    end
  end
end
