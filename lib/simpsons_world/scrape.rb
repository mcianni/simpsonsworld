module SimpsonsWorld
  BASE_URL = "http://www.simpsonsworld.com"
  EPISODES_URL = "/browse/episodes"

  class Scrape
    require 'nokogiri'
    require 'open-uri'

    def self.all
      doc = Nokogiri::HTML(open BASE_URL << EPISODES_URL)
      seasons = doc.css(".chapters-wrapper")
      seasons.each_with_index do |season, i|
        number = season.attr 'data-season-number'
        episodes = season.css("ul.items > li").map.with_index(1) { |episode, j|
          [ j,
            {
              title:       episode.css('.category-thumb-expanded .thumbnail-text').text,
              description: clean_description(episode.css('.category-thumb-expanded .thumbnail-extra-text').text),
              url:         episode.css('a')[0]['href']
            }
          ]
        }.to_h
        SimpsonsWorld::Season.new(number, episodes)
      end
    end

    def self.clean_description str
      str.gsub(/SEASON PREMIERE\.|Presented by FXX\./i, '').strip
    end

  end

end
