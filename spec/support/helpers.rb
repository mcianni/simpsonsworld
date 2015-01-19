module Helpers

  def season_data season: 1
    [ season, (1..EPISODE_COUNT).map { |i| 
       [i, { title: "Episode #{i}", description: "Description #{i}", url: "/path/s#{season}-e#{i}" }]
      }.to_h ]
  end

end
