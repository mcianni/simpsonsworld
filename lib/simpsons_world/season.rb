module SimpsonsWorld
  class Season
    require 'yaml'
    attr_reader :number, :episodes

    def initialize number, episodes
      @number, @episodes, @@all = number, episodes, nil
      save
    end

    def save
      File.open(self.class.to_file_path(@number), 'w') do |file|
        file.write [@number, @episodes].to_yaml
      end
    end

    class << self
      def all
        @@all ||= init
      end

      def init
        Dir.glob(to_file_path("*")).map { |file| YAML.load_file(file) }.to_h
      end

      def find number
        all[number]
      end

      def to_file_path number
        File.join(DATA_DIR, "season-#{number}.yml")
      end
    end

  end
end
