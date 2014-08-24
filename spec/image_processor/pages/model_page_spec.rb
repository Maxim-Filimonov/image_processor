require 'image_processor/pages/model_page'

describe ImageProcessor::Pages::ModelPage do
  describe '#thumbnails' do
    it 'displays all thumbnails' do
      model = instance_double('ImageProcessor::Model', works: (0...12))

      subject = described_class.new(model: model)

      expect(subject.thumbnails.length).to eq(model.works.to_a.length)
    end

    it 'returns thumbnail' do
      model = instance_double('ImageProcessor::Model', works: [1])
      thumbnail = class_double('ImageProcessor::Thumbnail').as_stubbed_const
      allow(thumbnail).to receive(:new).and_return(:thumbnail)

      subject = described_class.new(model: model)

      expect(subject.thumbnails.first).to eq(:thumbnail)
    end
  end

  describe '#nav' do
    it 'has index nav as first element' do
      model = instance_double('ImageProcessor::Model', make_name: 'bla')

      subject = described_class.new(model: model).nav.first

      expect(subject.url).to include('index.html')
    end

    it 'has make as second element' do
      model = instance_double('ImageProcessor::Model', make_name: 'CANON')

      subject = described_class.new(model: model).nav.last

      expect(subject.url).to include('canon/index')
    end
  end
end
