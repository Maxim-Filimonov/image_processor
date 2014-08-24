require 'image_processor/pages/index_page'

describe ImageProcessor::Pages::IndexPage do
  describe '#thumbnails' do
    it 'displays only first 10 thumbnails' do
      image_index = instance_double('ImageProcessor::ImageIndex', all_models: (0..12))

      subject = described_class.new(image_index: image_index)

      expect(subject.thumbnails.length).to eq(10)
    end

    it 'returns thumbnail' do
      image_index = instance_double('ImageProcessor::ImageIndex', all_models: [1])
      thumbnail = class_double('ImageProcessor::Thumbnail').as_stubbed_const
      allow(thumbnail).to receive(:new).and_return(:thumbnail)

      subject = described_class.new(image_index: image_index)

      expect(subject.thumbnails.first).to eq(:thumbnail)
    end
  end
end
