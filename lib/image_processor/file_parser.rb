require 'nokogiri'
require 'image_processor/work'

module ImageProcessor
  class FileParser
    attr_reader :file_path

    def initialize(args={})
      @file_path = args.fetch(:file_path)
    end

    def parse
      f = File.open(file_path)
      doc = Nokogiri::XML(f)
      work = doc.css('works work')
      work.map {|work|
        model = work.css('model').text
        make = work.css('make').text
        urls = {
          small: work.css('url[type=small]').text,
          medium: work.css('url[type=medium]').text,
          large: work.css('url[type=large]').text
        }
        original_time = work.css('date_time_original').text

        Work.new(model: model, make: make, urls: urls, original_time: original_time)
      }
    end
  end
end
