require 'image_processor/batch_processor'
require 'image_processor/file_parser'
require 'image_processor/output_writer'
require 'image_processor/html_rendered'
require 'image_processor/router'

module ImageProcessor
  class Runner
    attr_reader :data, :out_dir
    def initialize(args={})
      @data = args.fetch(:input_file)
      @out_dir = args.fetch(:out_dir)
    end

    def execute
      parser = FileParser.new(file_path: data)
      process_result = BatchProcessor.new(parser: parser).process

      router = Router.new(root: out_dir)
      rendering_result = HTMLRenderer.new(image_index: process_result, router: router).render

      writer = OutputWriter.new(rendering_result, out_dir: out_dir)
      writer.write
    end
  end
end
