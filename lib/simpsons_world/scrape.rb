module SimpsonsWorld
  BASE_URL = "http://www.simpsonsworld.com"
  EPISODES_URL = "/watch/episodes"

  class Scrape
    require 'nokogiri'
    require 'open-uri'

    def self.all
      doc = Nokogiri::HTML(open BASE_URL << EPISODES_URL)
      seasons = doc.css(".chapters-wrapper")
      seasons.each_with_index do |season, i|
        number = season.attr 'data-season-number'
        episodes = season.css("ul.items > li").map { |episode|
          {
            title:       episode.css('.category-thumb-expanded .thumbnail-text').text,
            description: episode.css('.category-thumb-expanded .thumbnail-extra-text').text,
            url:         episode.css('a')[0]['href']
          }
        }
        SimpsonsWorld::Season.new(number, episodes)
      end
    end
  end

end
