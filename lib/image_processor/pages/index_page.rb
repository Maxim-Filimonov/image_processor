require 'image_processor/pages/base_page'
require 'image_processor/thumbnail'
require 'image_processor/nav_link'

module ImageProcessor
  module Pages
    class IndexPage < BasePage
      attr_reader :image_index, :router
      def initialize(args={})
        @image_index = args.fetch(:image_index)
        @router = args.fetch(:router)
        super(args)
      end

      def thumbnails
        image_index.all_works.first(10).map { |model|
          Thumbnail.new(model)
        }
      end

      def nav
        image_index.makes.map { |make, _|
          nav_link = NavLink.new(url: router.make_path(make), name: make)
        }
      end

      def path
        router.index_path
      end

      def title
        "Image index"
      end
    end
  end
end
