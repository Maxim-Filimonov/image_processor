require 'image_processor/batch_processor'

describe ImageProcessor::BatchProcessor do
  describe '#process' do
    it 'groups works by make' do
      file_parser = instance_double('ImageProcessor::FileParser')
      subject = described_class.new(parser: file_parser)
      works = [
        instance_double('ImageProcessor::Work', make: 'CANON', model: ''),
        instance_double('ImageProcessor::Work', make: 'CANON', model: ''),
        instance_double('ImageProcessor::Work', make: 'NIKON', model: ''),
      ]

      allow(file_parser).to receive(:parse).and_return(works)

      result = subject.process
      expect(result.makes.keys).to contain_exactly('CANON', 'NIKON')
      expect(result.makes['CANON'].all_models.length).to eq(2)
      expect(result.makes['NIKON'].all_models.length).to eq(1)
    end

    it 'groups work by model in make' do
      file_parser = instance_double('ImageProcessor::FileParser')
      subject = described_class.new(parser: file_parser)
      works = [
        instance_double('ImageProcessor::Work', model: 'canon 1', make: 'canon'),
        instance_double('ImageProcessor::Work', model: 'canon 1', make: 'canon'),
        instance_double('ImageProcessor::Work', model: 'canon 2', make: 'canon'),
      ]

      allow(file_parser).to receive(:parse).and_return(works)

      result = subject.process
      expect(result.makes['canon'].models['canon 1'].length).to eq(2)
      expect(result.makes['canon'].models['canon 2'].length).to eq(1)
    end
  end
end
