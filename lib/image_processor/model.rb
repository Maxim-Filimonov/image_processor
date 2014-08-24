module ImageProcessor
  class Model
    attr_reader :name, :works, :make

    def initialize(args={})
      @name = args.fetch(:name)
      @make = args.fetch(:make)
      @works = []
    end

    def make_name
      make.name
    end
  end
end
