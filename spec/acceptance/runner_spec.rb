require 'image_processor/runner'

describe ImageProcessor::Runner do
  it 'can run with test data' do
    input_file = File.expand_path('../../../data/works.xml', __FILE__)
    out_dir = File.expand_path('../../../out/', __FILE__)

    described_class.new(input_file: input_file, out_dir: out_dir).execute

    assert_file_exists(out_dir, 'index.html')
    assert_file_exists(out_dir, 'canon/index.html')
    assert_file_exists(out_dir, 'canon/canon_eos_20_d.html')
  end

  def assert_file_exists(out_dir, path)
    file_path = File.join(out_dir, path)
    expect(File.exists?(file_path)).to eq(true)
  end
end
