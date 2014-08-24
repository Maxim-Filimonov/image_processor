require 'date'
module ImageProcessor
  class Work
    attr_reader :model, :make, :urls, :original_time

    def initialize(args={})
      @model = args.fetch(:model)
      @make = args.fetch(:make)
      @urls = args.fetch(:urls)
      original_time = args.fetch(:original_time)
      if original_time.empty?
        original_time = args.fetch(:date_time)
      end
      @original_time = DateTime.parse(original_time)
    end
  end
end
