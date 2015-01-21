require 'simpsons_world/view_helpers'

module SimpsonsWorld
  class Railtie < Rails::Railtie
    initializer "simpsons_world.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
