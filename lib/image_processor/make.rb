module ImageProcessor
  class Make
    attr_reader :models
    attr_accessor :name
    def initialize
      @models = {}
      @name = nil
    end
    def all_models
      models.map {|k,v| v }.flatten
    end
  end
end
