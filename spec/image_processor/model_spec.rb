require 'image_processor/model'

describe ImageProcessor::Model do
  describe '#make_name' do
    it 'returns name of make' do
      make = instance_double('ImageProcessor::Make', name: 'CANON')
      subject = described_class.new(make: make, name: '')

      expect(subject.make_name).to eq('CANON')
    end
  end
end
