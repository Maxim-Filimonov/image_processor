require 'image_processor/file_parser'
require 'image_processor/make'
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
        sum.makes[work.make] ||= Make.new
        make = sum.makes[work.make]
        make.name = work.make
        make.models[work.model] ||= []
        make.models[work.model] << work
        sum
      }
    end
  end
end
