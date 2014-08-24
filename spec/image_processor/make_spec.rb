require 'image_processor/make'

describe ImageProcessor::Make do
  describe '#all_models' do
    it 'returns all models' do
      subject.models['canon model'] = [1,2]
      subject.models['nikon model'] = [3,4]

      expect(subject.all_models).to contain_exactly(1,2,3,4)
    end
  end

end
