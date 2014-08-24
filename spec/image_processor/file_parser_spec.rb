require 'image_processor/file_parser'
require 'date'

describe ImageProcessor::FileParser do
  describe '#parse' do
    it 'returns all works from the file' do
      subject = described_class.new(file_path: load_fixture('two_works.xml'))

      result = subject.parse

      expect(result.length).to eq(2)
    end

    context 'parsing' do
      let(:parser) { described_class.new(file_path: load_fixture('two_works.xml'))}
      subject { parser.parse.first }
      its(:model) { is_expected.to eq("NIKON D80") }
      its(:make)  { is_expected.to eq("NIKON CORPORATION") }
      its(:urls)  { is_expected.to eq(
        {
          small: "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg",
          medium: "http://ih1.redbubble.net/work.31820.1.flat,300x300,075,f.jpg",
          large:  "http://ih1.redbubble.net/work.31820.1.flat,550x550,075,f.jpg"
        })
      }
      its(:original_time) { is_expected.to eq(DateTime.parse('Mon Jun 04 14:33:59 +1000 2007'))}
    end
  end
end
