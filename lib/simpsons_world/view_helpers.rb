module SimpsonsWorld
  module ViewHelpers

    def self.episode_url season:nil, episode:
      season = 1 + Season.all.take_while { |k, episodes|
        episode -= episodes.size if episode > episodes.size
      }.size unless season
      "#{BASE_URL}#{Season.all[season][episode][:url]}"
    end

  end
end
