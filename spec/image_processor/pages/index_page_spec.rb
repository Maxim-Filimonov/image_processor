require 'image_processor/pages/index_page'

describe ImageProcessor::Pages::IndexPage do
  let(:image_index) { instance_double('ImageProcessor::ImageIndex') }
  let(:router) { instance_double('ImageProcessor::Router', make_path: '') }
  subject { described_class.new(image_index: image_index, router: router) }

  describe '#thumbnails' do
    it 'displays only first 10 thumbnails' do
      allow(image_index).to receive(:all_works) { (0..12) }

      expect(subject.thumbnails.length).to eq(10)
    end

    it 'returns thumbnail' do
      allow(image_index).to receive(:all_works) { [1] }
      thumbnail = class_double('ImageProcessor::Thumbnail').as_stubbed_const
      allow(thumbnail).to receive(:new).and_return(:thumbnail)

      expect(subject.thumbnails.first).to eq(:thumbnail)
    end
  end

  describe '#nav' do
    it 'returns nav element for each make' do
      allow(image_index).to receive(:makes) { {
        'CANON' => instance_double('ImageProcessor::Make', name: 'CANON'),
        'NIKON' => instance_double('ImageProcessor::Make', name: 'NIKON')
      } }

      expect(subject.nav.length).to eq(2)
    end

    it 'users make url' do
      allow(image_index).to receive(:makes) { {
        'CANON' => instance_double('ImageProcessor::Make', name: 'CANON')
      } }
      allow(router).to receive(:make_path).with('CANON') { '/canon/index.html'}

      expect(subject.nav.first.url).to eq('/canon/index.html')
      expect(subject.nav.first.name).to eq('CANON')
    end
  end
end
