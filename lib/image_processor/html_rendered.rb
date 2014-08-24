require 'erb'
require 'image_processor/pages/index_page'
require 'image_processor/pages/make_page'
require 'image_processor/pages/model_page'

module ImageProcessor
  class HTMLRenderer
    attr_reader :image_index

    def initialize(args={})
      @image_index = args.fetch(:image_index)
    end

    def render
      index_page = Pages::IndexPage.new(image_index: image_index, template: template)
      index = index_page.result
      makes_pages = {}
      models_pages = {}
      image_index.makes.each do |_, make|
        make_page = Pages::MakePage.new(make: make, template: template)
        makes_pages[make_page.path] = make_page.result
        make.all_models.each do |model|
          model_page = Pages::ModelPage.new(model: model, template: template)
          models_pages[model_page.path] = model_page.result
        end
      end
      {
        index: index,
        makes: makes_pages,
        models: models_pages
      }
    end

    def template
      template = File.read(File.expand_path('../../../data/output-template.erb', __FILE__))
    end

    def title
      'test title'
    end
  end
end
