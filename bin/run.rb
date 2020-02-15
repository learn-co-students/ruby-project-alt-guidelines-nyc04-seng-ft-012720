require_relative '../config/environment'
require_relative '../lib/cli'
require 'pry'

cli = CommandLineInterface.new
cli.run


# binding.pry
# puts "hello world"
