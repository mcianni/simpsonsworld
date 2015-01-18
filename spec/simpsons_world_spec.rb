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
  EPISODE_COUNT = 5

  let(:data) { 
    [1, (1..EPISODE_COUNT).map { |i| 
      { title: "Episode #{i}", description: "Description #{i}", url: "/path/#{i}" }
    }]
  }
  
  let(:data2) { data.tap { |i| i[0] = 2 } }

  def create_season d=data
    @season = SimpsonsWorld::Season.new(*d)
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
    create_season.save
    expect File.exists?(SimpsonsWorld::Season::to_file_path(@season.number))
  end

  it "should save multiple seasons to multiple files" do
    purge_test_data
    create_season.save
    create_season(data2).save
    expect( Dir[File.join(SimpsonsWorld::DATA_DIR, "season-*.yml")].count ).to eql 2
  end

  it "should load the data on demand when looking for one season" do
    purge_test_data
    create_season.save
    expect( SimpsonsWorld::Season.find(1) ).to_not be(nil)
  end

  it "should load the data on demand when requesting all seasons" do
    purge_test_data
    create_season.save
    expect( SimpsonsWorld::Season.all ).to_not be(nil)
  end

  it "shouldn't reload the data once it's been loaded" do
    purge_test_data
    create_season.save
    expect( SimpsonsWorld::Season.all.object_id ).to eql( SimpsonsWorld::Season.all.object_id )
  end

  it "should not find a non-existent season" do
    purge_test_data
    create_season.save
    expect( SimpsonsWorld::Season.find(50) ).to be(nil)
  end
end
