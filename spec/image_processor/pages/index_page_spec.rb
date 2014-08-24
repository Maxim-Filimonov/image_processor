require 'image_processor/pages/index_page'

describe ImageProcessor::Pages::IndexPage do
  describe '#thumbnails' do
    it 'displays only first 10 thumbnails' do
      image_index = instance_double('ImageProcessor::ImageIndex', all_works: (0..12))

      subject = described_class.new(image_index: image_index)

      expect(subject.thumbnails.length).to eq(10)
    end

    it 'returns thumbnail' do
      image_index = instance_double('ImageProcessor::ImageIndex', all_works: [1])
      thumbnail = class_double('ImageProcessor::Thumbnail').as_stubbed_const
      allow(thumbnail).to receive(:new).and_return(:thumbnail)

      subject = described_class.new(image_index: image_index)

      expect(subject.thumbnails.first).to eq(:thumbnail)
    end
  end

  describe '#nav' do
    it 'returns nav element for each make' do
      image_index = instance_double('ImageProcessor::ImageIndex', makes: {
        'CANON' => instance_double('ImageProcessor::Make', name: 'CANON'),
        'NIKON' => instance_double('ImageProcessor::Make', name: 'NIKON')
      })

      subject = described_class.new(image_index: image_index)

      expect(subject.nav.length).to eq(2)
    end

    it 'users make url' do
      image_index = instance_double('ImageProcessor::ImageIndex', makes: {
        'CANON' => instance_double('ImageProcessor::Make', name: 'CANON')
      })

      subject = described_class.new(image_index: image_index)

      expect(subject.nav.first.url).to eq('/canon/index.html')
      expect(subject.nav.first.name).to eq('CANON')
    end
  end
end
