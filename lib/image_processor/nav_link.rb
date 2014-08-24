module ImageProcessor
  class NavLink
    attr_reader :url, :name
    def initialize(args={})
      @url = args.fetch(:url)
      @name = args[:name]
    end
  end
end
