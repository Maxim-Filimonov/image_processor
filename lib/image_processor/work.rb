require 'date'
module ImageProcessor
  class Work
    attr_reader :model, :make, :urls, :original_time

    def initialize(args={})
      @model = args[:model].empty? ? 'Unrecognized model' : args[:model]
      @make = args[:make].empty? ? 'Unrecognized make' : args[:make]
      @urls = args.fetch(:urls)
      original_time = args.fetch(:original_time)
      if original_time.empty?
        original_time = args.fetch(:date_time)
      end
      @original_time = DateTime.parse(original_time)
    end
  end
end
