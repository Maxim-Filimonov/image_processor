require 'erb'
require 'image_processor/thumbnail'
require 'image_processor/nav_link'
require 'image_processor/routes'

module ImageProcessor
  module Pages
    class MakePage < ERB
      attr_reader :make
      def initialize(args={})
        @make = args.fetch(:make)
        @template = args.fetch(:template, self.class.template)
        super(@template)
      end

      def thumbnails
        make.all_models.first(10).map { |model|
          Thumbnail.new(model)
        }
      end

      def nav
        index = NavLink.new(url: Routes.image_index_path, name: 'Index')
        model_urls = make.model_names.map { |model_name|
          nav_link = NavLink.new(url: Routes.model_path(make.name, model_name),
            name: model_name)
        }
        urls = []
        urls << index
        urls |= model_urls
      end

      def result
        super(binding)
      end

      def path
        Routes.make_path(make.name)
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
