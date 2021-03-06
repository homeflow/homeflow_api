## homeflow_api

The homeflow_api gem provides homeflow api v2 functions from ruby. This is alpha quality software and is in active development.

### Install

gem 'dry_ice', '0.1.1'

gem 'homeflow_api', :git => 'git://github.com/homeflow/homeflow_api.git'

### Initializer

Pop this in /config/initializers/homeflow.rb. Replace XXXXX for your API key.

```ruby

require 'homeflow/api'
require 'dry_ice'

Homeflow::API.configure do |config|
  config.api_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  config.source = 'http://index1.homeflow.co.uk'
end

module Homeflow
  module API
    class Request
      include HTTParty::DryIce
      cache Rails.cache, {:serialize => false}
    end
  end
end

```

### Contributing to homeflow_api

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so we don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or it is otherwise necessary, that is fine, but please isolate to its own commit so we can cherry-pick around it.

### Copyright

Copyright (c) 2011 Homeflow. See LICENSE.txt for
further details.
