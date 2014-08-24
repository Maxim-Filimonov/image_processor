require 'image_processor/batch_processor'

describe ImageProcessor::BatchProcessor do
  describe '#process' do
    it 'groups works by make' do
      file_parser = instance_double('ImageProcessor::FileParser')
      subject = described_class.new(parser: file_parser)
      works = [
        instance_double('ImageProcessor::Work', name: 'canon1', make: 'CANON', model: ''),
        instance_double('ImageProcessor::Work', name: 'canon2', make: 'CANON', model: ''),
        instance_double('ImageProcessor::Work', name: 'nikon1', make: 'NIKON', model: ''),
      ]

      allow(file_parser).to receive(:parse).and_return(works)

      result = subject.process
      expect(result.makes.keys).to contain_exactly('CANON', 'NIKON')
      expect(result.makes['CANON'].length).to eq(2)
      expect(result.makes['NIKON'].length).to eq(1)
    end

    it 'groups work by model' do
      file_parser = instance_double('ImageProcessor::FileParser')
      subject = described_class.new(parser: file_parser)
      works = [
        instance_double('ImageProcessor::Work', name: 'canon1', model: 'Canon EOS 20D', make: ''),
        instance_double('ImageProcessor::Work', name: 'canon2', model: 'Canon EOS 20D', make: ''),
        instance_double('ImageProcessor::Work', name: 'canon3', model: 'Canon EOS 70D', make: ''),
      ]

      allow(file_parser).to receive(:parse).and_return(works)

      result = subject.process
      expect(result.models['Canon EOS 20D'].length).to eq(2)
      expect(result.models['Canon EOS 70D'].length).to eq(1)
    end
  end
end
