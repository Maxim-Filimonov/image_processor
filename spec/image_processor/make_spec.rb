require 'image_processor/make'

describe ImageProcessor::Make do
  describe '#all_models' do
    it 'returns all models' do
      canon = instance_double('ImageProcessor::Work', model:'canon model')
      nikon = instance_double('ImageProcessor::Work', model: 'nikon model')
      subject.add_model(canon)
      subject.add_model(nikon)

      expect(subject.all_models).to contain_exactly(canon, nikon)
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

      expect(subject.get_works('canon 1')).to contain_exactly(work)
    end

    it 'keeps other models when adding a new one' do
      subject.add_model(work)
      subject.add_model(work)

      expect(subject.get_works('canon 1').length).to eq(2)
    end
  end
end
