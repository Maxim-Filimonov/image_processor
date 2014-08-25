require 'erb'
require 'image_processor/thumbnail'
require 'image_processor/nav_link'

module ImageProcessor
  module Pages
    class MakePage < ERB
      attr_reader :make, :router
      def initialize(args={})
        @make = args.fetch(:make)
        @template = args.fetch(:template, self.class.template)
        @router = args.fetch(:router)
        super(@template)
      end

      def thumbnails
        make.all_works.first(10).map { |model|
          Thumbnail.new(model)
        }
      end

      def nav
        index = NavLink.new(url: router.image_index_path, name: 'Index')
        model_urls = make.model_names.map { |model_name|
          nav_link = NavLink.new(url: router.model_path(make.name, model_name),
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
        router.make_path(make.name, file_path: true)
      end

      def self.template
       File.read(File.expand_path('../../../../data/output-template.erb', __FILE__))
      end

      def title
        "Make #{make.name}"
      end
    end
  end
end
