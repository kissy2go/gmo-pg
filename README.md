# GMO-PG

[![GitHub](https://img.shields.io/badge/github-kissy2go/gmo--pg-blue.svg)](https://github.com/kissy2go/gmo-pg)

[![Gem Version](https://badge.fury.io/rb/gmo-pg.svg)](https://badge.fury.io/rb/gmo-pg)
[![wercker status](https://app.wercker.com/status/1eb7ae8fcece997421923ffe8dc46ec7/s/master "wercker status")](https://app.wercker.com/project/byKey/1eb7ae8fcece997421923ffe8dc46ec7)
[![License](https://img.shields.io/badge/license-MIT-yellowgreen.svg)](#license)

The GMO-PG Ruby bindings provide a simple SDK for convenient access to the GMO-PG Multi-Payment API from application written in the Ruby language.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gmo-pg'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gmo-pg

## Usage

For example, to check card availability, like this:

```ruby
GMO::PG.base_url = 'https://...' # required

GMO::PG.connect do |dispatcher|
  dispatcher #=> #<GMO::PG::Dispatcher>

  credential = dispatcher.dispatch_entry_tran(
    shop_id:   YOUR_SHOP_ID,
    shop_pass: YOUR_SHOP_PASS,
    order_id:  order_id,
    job_cd:    :CHECK,
  )
  credential #=> #<GMO::PG::EntryTran::Response>

  result = dispatcher.dispatch_entry_tran(
    access_id:     credential.access_id,
    access_pass:   credential.access_pass,
    order_id:      order_id,
    card_no:       '...',
    expire:        '...',
    security_code: '...',
  )
  result #=> #<GMO::PG::ExecTran::Response>
end
```

## Development

After checking out the repo, install dependencies via bundler. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kissy2go/gmo-pg. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
