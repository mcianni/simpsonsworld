require 'spec_helper'
require 'fileutils'

describe SimpsonsWorld do
  EPISODE_COUNT = 5

  let(:season_one_data) { 
    [1, (1..EPISODE_COUNT).map { |i| 
      { title: "Episode #{i}", description: "Description #{i}", url: "/path/#{i}" }
    }]
  }
  
  let(:season_two_data) { season_one_data.tap { |i| i[0] = 2 } }

  def create_season data=nil
    @season = SimpsonsWorld::Season.new(*(data || season_one_data))
  end

  def purge_test_data
    FileUtils.rm_rf(File.dirname(__FILE__) + "/data/*")
  end

  it 'should return the correct episode' do
    create_season
    expect( @season.episodes[1] ).to eql(season_one_data[1][0])
  end

end
