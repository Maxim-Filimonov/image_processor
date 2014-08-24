require 'image_processor/nav_link'

describe ImageProcessor::NavLink do
  describe '#initialize' do
    it 'makes all links relative' do
      subject = described_class.new(url: '/canon/index.html')
      expect(subject.url).to eq('./canon/index.html')
    end
  end
end
