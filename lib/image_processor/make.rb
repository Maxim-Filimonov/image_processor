require 'image_processor/model'

module ImageProcessor
  class Make
    attr_reader :models
    attr_accessor :name

    def initialize(args={})
      @models = {}
      @name = args[:name]
    end

    def all_models
      models.map {|k,v| v.works }.flatten
    end

    def model_names
      models.keys
    end

    def get_works(model_name)
      models[model_name].works
    end

    def add_model(work)
      models[work.model] ||= Model.new(name: work.model, make: self)
      models[work.model].works << work
    end
  end
end
