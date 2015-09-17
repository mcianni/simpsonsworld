require 'spec_helper'
require 'fileutils'

describe SimpsonsWorld do
  describe "test suite" do
    it 'should not touch the real data dir' do
      expect( SimpsonsWorld::DATA_DIR ).to include("/spec/")
    end
  end
end

describe SimpsonsWorld do
  include Helpers
  include SimpsonsWorld::ViewHelpers

  EPISODE_COUNT = 5

  let(:season_one_data)   { season_data }
  let(:season_two_data)   { season_data(season: 2) }
  let(:season_three_data) { season_data(season: 3) }

  def create_season data=nil
    @season = SimpsonsWorld::Season.new(*(data || season_one_data))
  end

  def purge_test_data
    FileUtils.rm_rf(Dir.glob(File.join(File.dirname(__FILE__), "/data/*.yml")))
  end

  #it 'successfully parses the current markup' do
  #  expect{ SimpsonsWorld::Scrape.all }.to_not raise_error
  #end

  it 'should have a legit fixture' do
    expect { create_season }.to_not raise_error
  end

  before(:each) do
    purge_test_data
    create_season
  end

  it 'should set the season number' do
    expect( @season.number ).to eql(1)
  end

  it 'should set the episodes' do
    expect( @season.episodes ).not_to be_nil
  end

  it "should set #{EPISODE_COUNT} episodes" do
    expect( @season.episodes.count ).to eql(EPISODE_COUNT)
  end
 
  it "should save the data to file" do
    expect File.exists?(SimpsonsWorld::Season::to_file_path(@season.number))
  end

  it "should save multiple seasons to multiple files" do
    create_season(season_two_data)
    expect( Dir[File.join(SimpsonsWorld::DATA_DIR, "season-*.yml")].count ).to eql 2
  end

  it "should load the data on demand when looking for one season" do
    expect( SimpsonsWorld::Season.find(1) ).to_not be(nil)
  end

  it "should load the data on demand when requesting all seasons" do
    expect( SimpsonsWorld::Season.all ).to_not be(nil)
  end

  it "shouldn't reload the data once it's been loaded" do
    expect( SimpsonsWorld::Season.all.object_id ).to eql( SimpsonsWorld::Season.all.object_id )
  end

  it "should reload the data if a new season has been added" do
    obj_id = SimpsonsWorld::Season.all.object_id
    create_season(season_two_data)
    expect( SimpsonsWorld::Season.all.object_id ).not_to eql( obj_id )
  end

  it "should not find a non-existent season" do
    expect { SimpsonsWorld::Season.find(50) }.to raise_error
  end

  it 'should return the correct episode' do
    expect( @season.episodes[1] ).to eql(season_one_data[1][1])
  end

  it 'should set the correct path' do
    expect( @season.episodes[1][:url] ).to eql("/path/s1-e1")
  end

  describe "url finders" do
    before(:all) do
      @view = Object.new
      @view.extend(SimpsonsWorld::ViewHelpers)
    end

    it 'should return the correct url for episode number' do
      expect( @view.simpsons_world_episode_url(episode: 1) ).to \
        eql("http://www.simpsonsworld.com/path/s1-e1")
    end

    it 'should return the correct url for season and episode number' do
      expect( @view.simpsons_world_episode_url(season: 1, episode: 1) ).to match(/s1-e1/)
    end

    it 'should return the correct url for a season 2 episode' do
      create_season(season_two_data)
      expect( @view.simpsons_world_episode_url(episode: 6) ).to match(/s2-e1/)
    end

    it 'should return the correct url for a season 1 finale' do
      create_season(season_two_data)
      expect( @view.simpsons_world_episode_url(episode: 5) ).to match(/s1-e5/)
    end

    it 'should return the correct url for a season 3 episode' do
      create_season(season_two_data) and create_season(season_three_data)
      expect( @view.simpsons_world_episode_url(episode: 14) ).to match(/s3-e4/)
    end

    it "should return an empty string if the season doesn't exist" do
      expect( @view.simpsons_world_episode_url(season: 5, episode: 1) ).to eql('')
    end

    it "should return an empty string if the episode doesn't exist" do
      expect( @view.simpsons_world_episode_url(episode: 9999) ).to eql('')
    end
  end

end
