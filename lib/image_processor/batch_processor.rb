require 'image_processor/file_parser'
require 'ostruct'

module ImageProcessor
  class BatchProcessor
    attr_reader :parser

    def initialize(args={})
      @parser = args.fetch(:parser, ImageProcessor::FileParser.new)
    end
    def process
      works = parser.parse

      works.inject(OpenStruct.new(makes: {}, models: {})) { |sum, work|
        sum.makes[work.make] ||= []
        sum.makes[work.make] << work
        sum.models[work.model] ||= []
        sum.models[work.model] << work
        sum
      }
    end
  end
end
