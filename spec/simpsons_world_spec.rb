require 'spec_helper'
require 'fileutils'

describe SimpsonsWorld do
  #SimpsonsWorld::DATA_DIR = File.join(File.dirname(__FILE__), "data")
  EPISODE_COUNT = 5

  let(:data) { 
    [1, (1..EPISODE_COUNT).map { |i| 
      { title: "Episode #{i}", description: "Description #{i}", url: "/path/#{i}" }
    }]
  }

  def create_season
    @season = SimpsonsWorld::Season.new(*data)
  end

  def purge_test_data
    FileUtils.rm_rf(File.dirname(__FILE__) + "/data/*")
  end

  #it 'successfully parses the current markup' do
  #  expect{ SimpsonsWorld::Scrape.all }.to_not raise_error
  #end

  it 'should have a legit fixture' do
    expect { create_season }.to_not raise_error
  end

  it 'should set the season number' do
    create_season
    expect( @season.number ).to eql(1)
  end

  it 'should set the episodes' do
    create_season
    expect( @season.episodes ).not_to be_nil
  end

  it "should set #{EPISODE_COUNT} episodes" do
    create_season
    expect( @season.episodes.count ).to eql(EPISODE_COUNT)
  end
 
  it "should save the data to file" do
    purge_test_data
    #puts SimpsonsWorld::DATA_DIR
    create_season.save
    expect File.exists?(SimpsonsWorld::DATA_DIR + "/season-#{@season.number}.yml")
  end

end
