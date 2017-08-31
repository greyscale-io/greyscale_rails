# GreyscaleRails
This is a collection of handy tools to make your life developing against the [Greyscale.io](http://www.greyscale.io) platform easy and delightful. 

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'greyscale_rails'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install greyscale_rails
```

## Usage

There are a few things this gem provides

### Config

[GreyscaleRecord](http://github.com/greyscale-io/greyscale_record) is the default ORM for the Greyscale.io platform and there's some configuration that needs to happen, but it's somewhat verbose. To spare you the pain of reading all those docs, you can configure everything in a single yaml file: `greyscale.yml`

Here's what it looks like

```yml
development:
  driver: yaml
  data_root: db/fixtures
  live_reload: true

test:
  driver: yaml
  data_root: test/db/fixtures

# currently not supported.
production:
  driver: greyscale
  data_root: http://api.greyscale.io
  revision_root: http://revisions.greyscale.io
  app_id: <APP_ID>
  app_key: <APP_KEY>
```

Here's what all the fields are:

* `driver`: tells the application to load the proper data fetcher. The options are
  * `yaml`: will load yaml files from your local file system folder, specified by `data_root`
  * `greyscale`: will load data from a remote server that complies to the Greyscale.io API standard
* `data_root`: the root path of the source from which you want to load your data
* `revision_root`: the root path of the source from which you load data [previews](#patchable)
* `app_id`: Your app's Greyscale.io API id
* `app_key`: Your app's Greyscale.io API key

### Patchable 

This is a module that's loaded into Application Controller that detects a revision key in `params[:revision]`, and automatically applies the patch for the duration of the call.

__NOTE__: it applies it to `GreycaleRecord::Base`'s data store, so if you have more than one store that you are using, this may not work as well as you hope. 

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
