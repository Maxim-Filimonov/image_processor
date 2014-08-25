require 'image_processor/pages/base_page'
require 'image_processor/thumbnail'
require 'image_processor/nav_link'

module ImageProcessor
  module Pages
    class ModelPage < BasePage
      attr_reader :model, :router
      def initialize(args={})
        @model = args.fetch(:model)
        @router = args.fetch(:router)
        super(args)
      end

      def thumbnails
        model.works.map { |work|
          Thumbnail.new(work)
        }
      end

      def nav
        index = NavLink.new(url: router.image_index_path, name: 'Index')
        make = NavLink.new(url: router.make_path(model.make_name), name: model.make_name)
        urls = []
        urls << index
        urls << make
      end

      def path
        router.model_path(model.make_name, model.name, file_path: true)
      end

      def title
        "Model #{model.name}"
      end
    end
  end
end
