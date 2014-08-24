require 'erb'
require 'image_processor/pages/index_page'
require 'image_processor/pages/make_page'

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
      makes_pages = image_index.makes.inject({}) {|sum, make_el|
        make = make_el[1]
        page = Pages::MakePage.new(make: make, template: template)
        sum[page.path.to_sym] = page.result
        sum
      }
      {
        index: index,
        makes: makes_pages
      }
    end

    def title
      'test title'
    end
  end
end
