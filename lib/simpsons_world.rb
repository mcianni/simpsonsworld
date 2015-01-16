require "simpsons_world/version"
require 'simpsons_world/season'
require 'simpsons_world/scrape'
require 'pry'

module SimpsonsWorld
  DATA_DIR = ENV['environment'] && ENV['environment'] == 'test' ? 
    File.join(File.dirname(__FILE__), '..', 'spec', 'data') :
    File.join(File.dirname(__FILE__), 'data')
end
