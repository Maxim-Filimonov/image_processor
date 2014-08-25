require 'image_processor/work'

describe ImageProcessor::Work do
  describe '#initialize' do
    let(:args) { {model: 'canon 1', make: 'canono', urls: {},
      original_time: 'Mon Jun 04 14:33:59 +1000 2007'}}
    it 'uses date time if original date time is empty' do
      args[:original_time] = ""
      args[:date_time] = 'Mon Jun 04 14:33:59 +1000 2007'

      result = described_class.new(args)
      expect(result.original_time).to_not be_nil
    end

    it 'uses Unrecognized make when make is not provided' do
      args[:make] = ""

      result = described_class.new(args)

      expect(result.make).to eq('Unrecognized make')
    end

    it 'users Unrecognized model when model is not provided' do
      args[:model] = ""

      result = described_class.new(args)

      expect(result.model).to eq('Unrecognized model')
    end
  end
end
