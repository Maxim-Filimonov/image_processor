require 'image_processor/pages/make_page'

describe ImageProcessor::Pages::MakePage do
  describe '#thumbnails' do
    it 'displays only first 10 thumbnails' do
      make = instance_double('ImageProcessor::Make', all_works: (0..12))

      subject = described_class.new(make: make)

      expect(subject.thumbnails.length).to eq(10)
    end

    it 'returns thumbnail' do
      make = instance_double('ImageProcessor::Make', all_works: [1])
      thumbnail = class_double('ImageProcessor::Thumbnail').as_stubbed_const
      allow(thumbnail).to receive(:new).and_return(:thumbnail)

      subject = described_class.new(make: make)

      expect(subject.thumbnails.first).to eq(:thumbnail)
    end
  end

  describe '#nav' do
    it 'has index nav as first element' do
      make = instance_double('ImageProcessor::Make', name: 'CANON', model_names: [])

      subject = described_class.new(make: make).nav.first

      expect(subject.url).to include('index.html')
    end

    it 'returns nav element for each model' do
      make = instance_double('ImageProcessor::Make', name: 'CANON', model_names:
        ['canon 1', 'canon 2'])

      subject = described_class.new(make: make)

      expect(subject.nav.length).to eq(3)
    end

    it 'generates model url' do
      make = instance_double('ImageProcessor::Make', name: 'CANON', model_names:
        ['canon 1'])

      subject = described_class.new(make: make).nav.last

      expect(subject.url).to eq('/canon/canon_1.html')
      expect(subject.name).to eq('canon 1')
    end
  end
end
