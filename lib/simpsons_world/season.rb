module SimpsonsWorld
  class Season
    require 'yaml'
    attr_reader :number, :episodes
    @@all = {}

    def initialize number, episodes
      @number, @episodes = number, episodes
      save
    end

    def save
      File.open(Season::to_file_path(@number), 'w') do |file|
        file.write [@number, @episodes].to_yaml
      end
    end

    # class methods
    def self.all
      @@all
    end

    def self.find number
      load_season(number) unless @@all[number]
      @@all[number]
    end

    def self.load_season number
      @@all[number] = YAML.load_file(to_file_path(number))[1] if File.exists?(to_file_path(number))
    end

    def self.to_file_path number
      File.join(DATA_DIR, "season-#{number}.yml")
    end

  end
end
