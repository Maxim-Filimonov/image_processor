require 'image_processor/pages/model_page'

describe ImageProcessor::Pages::ModelPage do
  let(:model) { instance_double('ImageProcessor::Model', name: '', make_name: '') }
  let(:router) { instance_double('ImageProcessor::Router', model_path: '')}
  subject { described_class.new(model: model, router: router) }

  describe '#thumbnails' do
    it 'displays all thumbnails' do
      allow(model).to receive(:works) { (0...12) }

      expect(subject.thumbnails.length).to eq(model.works.to_a.length)
    end

    it 'returns thumbnail' do
      allow(model).to receive(:works) { [1] }
      thumbnail = class_double('ImageProcessor::Thumbnail').as_stubbed_const
      allow(thumbnail).to receive(:new).and_return(:thumbnail)

      expect(subject.thumbnails.first).to eq(:thumbnail)
    end
  end

  describe '#nav' do
    it 'has index nav as first element' do
      allow(router).to receive(:image_index_path) { 'index.html' }
      allow(router).to receive(:make_path) { '' }

      expect(subject.nav.first.url).to include('index.html')
    end

    it 'has make as second element' do
      allow(router).to receive(:image_index_path) { '' }
      allow(router).to receive(:make_path) { 'canon/index.html' }

      expect(subject.nav.last.url).to include('canon/index')
    end
  end
  describe '#path' do
    it 'returns path non relative to root' do
      allow(model).to receive(:name) { 'canon one' }
      allow(model).to receive(:make_name) { 'canon' }
      allow(router).to receive(:model_path).with('canon', 'canon one', file_path: true) { 'model_path'}

      expect(subject.path).to eq('model_path')
    end
  end
end
