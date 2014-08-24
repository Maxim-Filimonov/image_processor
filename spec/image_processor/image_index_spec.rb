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

      puts "MAKES - #{subject.makes}"
      expect(subject.makes['CANON']).to eq(make)
    end
  end
end
