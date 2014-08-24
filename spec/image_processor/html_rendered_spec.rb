require 'image_processor/html_rendered'
require 'image_processor/image_index'

describe ImageProcessor::HTMLRenderer do
  describe '#render' do
    it 'generates index page' do
      image_index = ImageProcessor::ImageIndex.new
      image_index.add_make('CANON')
      subject = described_class.new(image_index: image_index)

      result = subject.render

      expect(result[:index]).to_not be_nil
    end

    it 'generates page for each make' do
      image_index = ImageProcessor::ImageIndex.new
      image_index.add_make('CANON')
      image_index.add_make('NIKON')
      subject = described_class.new(image_index: image_index)

      result = subject.render

      expect(result[:makes].values.length).to eq(2)
    end

    it 'generates page for each model' do
    end

    # it 'does magic' do
    #   require 'image_processor/batch_processor'
    #   require 'image_processor/file_parser'
    #   file_path = File.expand_path('../../../data/works.xml', __FILE__)
    #   parser = ImageProcessor::FileParser.new(file_path: file_path)
    #   process_result = ImageProcessor::BatchProcessor.new(parser: parser).process
    #
    #   described_class.new(image_index: process_result).render
    # end
  end
end
