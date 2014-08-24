require 'image_processor/file_parser'
require 'image_processor/image_index'

module ImageProcessor
  class BatchProcessor
    attr_reader :parser

    def initialize(args={})
      @parser = args[:parser] || ImageProcessor::FileParser.new
    end
    def process
      works = parser.parse

      works.inject(ImageIndex.new) { |index, work|
        make = index.add_make(work.make)
        make.add_model(work)
        index
      }
    end
  end
end
