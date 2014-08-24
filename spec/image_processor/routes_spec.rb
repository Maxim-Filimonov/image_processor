require 'image_processor/routes'

describe ImageProcessor::Routes do
  describe '.make_path' do
    it 'lower cases make' do
      expect(described_class.make_path('CANON')).to include('canon')
    end

    it 'can handle make with spaces' do
      expect(described_class.make_path('FUJI CORPORATION')).to include('fuji_corporation')
    end
  end

  describe '.model_path' do
    it 'can handle model with spaces' do
      expect(described_class.model_path('FUJI CORPORATION', 'FUJI ONE')).to include('fuji_one')
    end
  end
end
