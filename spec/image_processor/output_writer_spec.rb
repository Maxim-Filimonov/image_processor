require 'image_processor/output_writer'

describe ImageProcessor::OutputWriter do
  include FakeFS::SpecHelpers

  describe '#write' do
    it 'creates a file for index in output directory' do
      input = {
        index: 'content'
      }
      subject = described_class.new(input, out_dir: '/tmp')

      subject.write

      expect(File.read('/tmp/index.html')).to eq('content')
    end

  it 'creates a file for each path in make' do
    input = {
      makes: {
        'canon/index.html' => 'content'
      }
    }
    subject = described_class.new(input, out_dir: '/tmp')

    subject.write

    expect(File.read('/tmp/canon/index.html')).to eq('content')
  end

  it 'creates a file for each model' do
    input = {
      models: {
        'canon/canon_d20.html' => 'content'
      }
    }
    subject = described_class.new(input, out_dir: '/tmp')

    subject.write

    expect(File.read('/tmp/canon/canon_d20.html')).to eq('content')
  end

  it 'cleans output directory' do
    input = {
      index: 'content'
    }
    FileUtils.mkdir_p('/tmp')
    FileUtils.touch('/tmp/trash')

    subject = described_class.new(input, out_dir: '/tmp')

    subject.write

    expect(File.exists?('/tmp/trash')).to eq(false)
  end
end
end
