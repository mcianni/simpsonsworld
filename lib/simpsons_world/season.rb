module SimpsonsWorld

  class Season
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
    end

  end

end
