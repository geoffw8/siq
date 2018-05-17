require 'pry'
require 'date'

require './lib/organisation'

Dir.glob(File.expand_path('lib/*', __dir__)).each(&method(:require))
