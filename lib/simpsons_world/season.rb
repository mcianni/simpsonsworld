module SimpsonsWorld
  #DATA_DIR = File.join(File.dirname(__FILE__), "..", "data")

  class Season
    require 'yaml'
    attr_reader :number, :episodes

    def initialize number, episodes
      @number, @episodes = number, episodes
      #puts "Season #{number} ============================="
      #puts episodes
      #puts "=============================================="
    end

    def self.find number
    end

    def save
      File.open(File.join(DATA_DIR, "season-#{@number}.yml"), 'w') do |file|
        file.write [@number, @episodes].to_yaml
      end
    end

  end

end
