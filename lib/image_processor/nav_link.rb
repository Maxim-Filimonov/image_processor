module ImageProcessor
  class NavLink
    attr_reader :url, :name
    def initialize(args={})
      @url = convert_to_relative(args.fetch(:url))
      @name = args[:name]
    end

    private
    def convert_to_relative(link)
      ".#{link}"
    end
  end
end
