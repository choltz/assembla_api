# AssemblaApi

Ruby wrapper for the Assembla API

## Installation

Add this line to your application's Gemfile:

    gem 'assembla_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install assembla_api

## Usage

Tell the API your key and secret:

    AssemblaApi::Config.key    = "your key"
    AssemblaApi::Config.secret = "your secret"

Then Make API calls:

    spaces  = AssemblaApi::Space.all
    tickets = spaces.first.tickets

## Custom Fields

    You can write custom Assembal ticket fields by wrapping them in a hash:

    AssemblaApi::Ticket.create :summary => "New ticket", :space_id => space.id, :custom_fields => { :your_custom_field => "custom field value" }


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
