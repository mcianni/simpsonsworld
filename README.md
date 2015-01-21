# SimpsonsWorld

Link to Simpsons episodes on the simpsonsworld.com website. Using either a season and episode number or an overall episode number this gem will generate a link to the episode streaming on the Simpsons World website.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simpsons_world'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simpsons_world

## Usage

Use the view helper to get a full url to an episode.

```ruby
simpsons_world_episode_url(season: 4, episode: 12) # http://www.simpsonsworld.com/video/306386499796
simpsons_world_episode_url(episode: 71)            # http://www.simpsonsworld.com/video/306386499796
```

## Contributing

1. Fork it ( https://github.com/mcianni/simpsons_world/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Disclaimer
This is *not* affiliated, in any way, with The Simpsons or Fox.
