module ImageProcessor
  class Make
    attr_reader :models
    attr_accessor :name

    def initialize(args={})
      @models = {}
      @name = args[:name]
    end

    def all_models
      models.map {|k,v| v }.flatten
    end

    def model_names
      models.keys
    end

    def add_model(work)
      models[work.model] ||= []
      models[work.model] << work
    end
  end
end
