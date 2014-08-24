require 'erb'
require 'image_processor/pages/index_page'

module ImageProcessor
  class HTMLRenderer
    attr_reader :image_index

    def initialize(args={})
      @image_index = args.fetch(:image_index)
    end

    def render
      template = File.read(File.expand_path('../../../data/output-template.erb', __FILE__))
      index_page = Pages::IndexPage.new(image_index: image_index, template: template)
      index = index_page.result
      { index: index }
    end

    def title
      'test title'
    end
  end
end
