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
  end
end
