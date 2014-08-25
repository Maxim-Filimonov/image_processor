#!/usr/bin/env ruby
$:.unshift(File.expand_path('./lib', File.dirname(__FILE__)))
require 'highline/import'
require 'image_processor/runner'
require 'optparse'

say "=== Welcome to Image Processor ==="
say "=================================="

options = {}
OptionParser.new do |opts|
  opts.on('-cmd','--non-interactive')  do
    options[:non_interactive] = true
  end
  opts.on('-i','--input-file FILE', String) do |file|
    options[:input_file] = file
  end
  opts.on('-o','--output-dir FILE', String) do |file|
    options[:out_dir] = file
  end
end.parse!

unless options[:non_interactive]
  options[:input_file] = ask('where is your data located (relative to current directory)') do |q|
    q.validate = -> (p) { File.exists?(p) }
  end

  options[:out_dir] = ask('where do you want output to be saved to (relative to current directory)')
end

input_file = File.expand_path(options[:input_file],'.')
out_dir = File.expand_path(options[:out_dir],'.')
say "Running processor on #{input_file}"
ImageProcessor::Runner.new(input_file: input_file, out_dir: out_dir).execute

say "All done. Check the output directory - #{out_dir}"
