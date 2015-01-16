require 'spec_helper'

describe SimpsonsWorld do

  it 'successfully parses the current markup' do
    expect{ SimpsonsWorld::Scrape.all }.to_not raise_error
  end

  
end
