require 'image_processor/pages/make_page'

describe ImageProcessor::Pages::MakePage do
  let(:make)  { instance_double('ImageProcessor::Make', name: '') }
  let(:router)  { instance_double('ImageProcessor::Router', model_path: '') }
  subject  { described_class.new(make: make, router: router) }
  describe '#thumbnails' do
    it 'displays only first 10 thumbnails' do
      allow(make).to receive(:all_works) { (0..12) }

      expect(subject.thumbnails.length).to eq(10)
    end

    it 'returns thumbnail' do
      allow(make).to receive(:all_works) { [1] }
      thumbnail = class_double('ImageProcessor::Thumbnail').as_stubbed_const
      allow(thumbnail).to receive(:new).and_return(:thumbnail)

      expect(subject.thumbnails.first).to eq(:thumbnail)
    end
  end

  describe '#nav' do
    before do
      allow(router).to receive(:image_index_path) { 'index.html' }
    end
    it 'has index nav as first element' do
      allow(make).to receive(:model_names) { []}

      expect(subject.nav.first.url).to include('index.html')
    end

    it 'returns nav element for each model' do
      allow(make).to receive(:model_names) { ['canon 1', 'canon 2'] }

      expect(subject.nav.length).to eq(3)
    end

    it 'generates model url' do
      allow(make).to receive(:model_names) { ['canon 1'] }
      allow(make).to receive(:name) { 'canon' }
      allow(router).to receive(:model_path).with('canon', 'canon 1') { '/canon/canon_1.html' }

      expect(subject.nav.last.url).to eq('/canon/canon_1.html')
      expect(subject.nav.last.name).to eq('canon 1')
    end
  end

  describe '#path' do
    it 'returns path non relative to root' do
      allow(make).to receive(:name) { 'canon' }
      allow(router).to receive(:make_path).with('canon', file_path: true) { 'make_path'}

      expect(subject.path).to eq('make_path')
    end
  end
end
