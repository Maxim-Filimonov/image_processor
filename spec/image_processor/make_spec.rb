require 'image_processor/make'

describe ImageProcessor::Make do
  describe '#all_models' do
    it 'returns all models' do
      subject.models['canon model'] = [1,2]
      subject.models['nikon model'] = [3,4]

      expect(subject.all_models).to contain_exactly(1,2,3,4)
    end
  end

  describe '#name' do
    it 'can be overriden on creation' do
      make = described_class.new(name: 'NIKON')

      expect(make.name).to eq('NIKON')
    end
  end

  describe '#add_model' do
    let(:work) { instance_double("ImageProcessor::Work", model: 'canon 1') }
    it 'adds model to models' do
      subject.add_model(work)

      expect(subject.models['canon 1']).to contain_exactly(work)
    end

    it 'keeps other models when adding a new one' do
      subject.add_model(work)
      subject.add_model(work)

      expect(subject.models['canon 1'].length).to eq(2)
    end
  end
end
