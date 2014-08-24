require 'image_processor/thumbnail'

describe ImageProcessor::Thumbnail do
  describe '#url' do
    it 'returns medium url from model' do
      model = instance_double('ImageProcessor::Work', urls: { medium: 'medium', small: 'small'})
      subject = described_class.new(model)

      expect(subject.url).to eq('medium')
    end
  end
end
