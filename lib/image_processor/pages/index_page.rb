require 'erb'
require 'image_processor/thumbnail'

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

      def template
        ''
      end
    end
  end
end
