require 'erb'
require 'image_processor/thumbnail'
require 'image_processor/nav_link'
require 'image_processor/routes'

module ImageProcessor
  module Pages
    class ModelPage < ERB
      attr_reader :model
      def initialize(args={})
        @model = args.fetch(:model)
        @template = args.fetch(:template, self.class.template)
        super(@template)
      end

      def thumbnails
        model.works.map { |work|
          Thumbnail.new(work)
        }
      end

      def nav
        index = NavLink.new(url: Routes.image_index_path, name: 'Index')
        make = NavLink.new(url: Routes.make_path(model.make_name), name: model.make_name)
        urls = []
        urls << index
        urls << make
      end

      def result
        super(binding)
      end

      def path
        Routes.model_path(model.make_name, model.name)
      end

      def self.template
       File.read(File.expand_path('../../../../data/output-template.erb', __FILE__))
      end

      def title
        "Image index"
      end
    end
  end
end
