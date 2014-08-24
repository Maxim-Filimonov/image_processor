require 'erb'
require 'image_processor/thumbnail'
require 'image_processor/nav_link'
require 'image_processor/routes'

module ImageProcessor
  module Pages
    class IndexPage < ERB
      attr_reader :image_index
      def initialize(args={})
        @image_index = args.fetch(:image_index)
      end

      def thumbnails
        image_index.all_models.first(10).map { |model|
          Thumbnail.new(model)
        }
      end

      def nav
        image_index.makes.map { |make|
          nav_link = NavLink.new(url: Routes.make_path(make.name), name: make.name)
        }
      end

      def template
        ''
      end
    end
  end
end
