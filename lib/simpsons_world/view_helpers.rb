module SimpsonsWorld
  module ViewHelpers

    def simpsons_world_episode_url season:nil, episode:
      season = 1 + Season.all.take_while { |k, episodes|
        episode -= episodes.size if episode > episodes.size
      }.size unless season
      begin
        "#{BASE_URL}#{Season.all[season][episode][:url]}"
      rescue NoEpisodeError, NoMethodError
        ''
      end
    end

  end
end
