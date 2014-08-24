# Add lib to load path
$:.push(File.join(__FILE__, "../lib"))

# Load support files
Dir[File.join(File.dirname(__FILE__), "/support/**/*.rb")].each {|f| require f}

require 'rspec/its'
require 'fakefs/spec_helpers'
RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect

    mocks.verify_partial_doubles = true
  end

  config.include FixtureLoader
end
