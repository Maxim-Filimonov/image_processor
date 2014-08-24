require 'image_processor/image_index'

describe ImageProcessor::ImageIndex do
  describe '#add_make' do
    it 'adds a make to makes using provided name' do
      subject.add_make('CANON')
      subject.add_make('NIKON')

      expect(subject.makes.keys).to contain_exactly('CANON', 'NIKON')
      expect(subject.makes['CANON'].name).to eq('CANON')
    end

    it 'does not add a make when one already exists' do
      make = subject.add_make('CANON')
      subject.add_make('CANON')

      expect(subject.makes['CANON']).to eq(make)
    end
  end

  describe '#all_models' do
    it 'returns all models from all makes' do
      make = subject.add_make('CANON')
      make.add_model(double(model: 'canon 1'))
      make.add_model(double(model: 'canon 2'))
      make = subject.add_make('NIKON')
      make.add_model(double(model: 'nikon 1'))

      expect(subject.all_models.map(&:model)).to contain_exactly('canon 1', 'canon 2', 'nikon 1')      
    end
  end
end
