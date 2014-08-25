#!/usr/bin/env ruby
$:.unshift(File.expand_path('./lib', File.dirname(__FILE__)))
require 'highline/import'
require 'image_processor/runner'

say "=== Welcome to Image Processor ==="
say "=================================="
entries = {}
entries[:input_file] = ask('where is your data located (relative to current directory)') do |q|
  q.validate = -> (p) { File.exists?(p) }
end

entries[:out_dir] = ask('where do you want output to be saved to') do |q|
end

input_file = File.expand_path(entries[:input_file],'.')
out_dir = File.expand_path(entries[:out_dir],'.')
say "Running processor on #{input_file}"
ImageProcessor::Runner.new(input_file: input_file, out_dir: out_dir).execute

say "All done. Check the output directory - #{out_dir}"
