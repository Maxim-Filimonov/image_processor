require 'image_processor/html_rendered'
require 'image_processor/image_index'
require 'image_processor/router'

describe ImageProcessor::HTMLRenderer do
  let(:image_index) { ImageProcessor::ImageIndex.new }
  let(:router) { ImageProcessor::Router.new(root: '/tmp')}
  subject { described_class.new(image_index: image_index, router: router) }
  describe '#render' do
    it 'generates index page' do
      image_index.add_make('CANON')

      result = subject.render

      expect(result[:index]).to_not be_nil
    end

    it 'generates page for each make' do
      image_index.add_make('CANON')
      image_index.add_make('NIKON')

      result = subject.render

      expect(result[:makes].values.length).to eq(2)
    end

    it 'generates page for each model' do
      make = image_index.add_make('CANON')
      make.add_model(instance_double('ImageProcessor::Work', model: 'canon 1', urls: {}))
      make.add_model(instance_double('ImageProcess::Work', model: 'canon 2', urls: {}))

      result = subject.render

      expect(result[:models].values.length).to eq(2)
    end

    it 'does magic' do
      require 'image_processor/batch_processor'
      require 'image_processor/file_parser'
      require 'image_processor/output_writer'
      file_path = File.expand_path('../../../data/works.xml', __FILE__)
      parser = ImageProcessor::FileParser.new(file_path: file_path)
      process_result = ImageProcessor::BatchProcessor.new(parser: parser).process

      router = ImageProcessor::Router.new(root: '/Users/maxim/repos/redbubble_image_process/output/')
      result = described_class.new(image_index: process_result, router: router).render

      writer = ImageProcessor::OutputWriter.new(result, out_dir: '/Users/maxim/repos/redbubble_image_process/output/')
      writer.write
    end
  end
end
