require 'image_processor/router'

describe ImageProcessor::Router do
  subject { described_class.new(root: '/out')}
  describe '#index_path' do
    it 'creates a path relative to root' do
      expect(subject.image_index_path).to include('/out')
    end
  end
  describe '#make_path' do
    it 'lower cases make' do
      expect(subject.make_path('CANON')).to include('canon')
    end

    it 'can handle make with spaces' do
      expect(subject.make_path('FUJI CORPORATION')).to include('fuji_corporation')
    end

    it 'creates a path relative to root' do
      expect(subject.make_path('CANON')).to include('/out')
    end
    it 'does not use root when it is filepath' do
      expect(subject.make_path('CANON', file_path: true)).to_not include('/out')
    end
  end

  describe '.model_path' do
    it 'can handle model with spaces' do
      expect(subject.model_path('FUJI CORPORATION', 'FUJI ONE')).to include('fuji_one')
    end

    it 'creates a path relative to root' do
      expect(subject.model_path('FUJI CORPORATION', 'FUJI ONE')).to include('/out')
    end
  end
end
