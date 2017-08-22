# Croner
An plugin that manage cron jobs each applications and servers.

*Read this in other languages: [日本語](README.ja.md)*

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'croner'
```

And then execute:
```bash
$ bundle
```

## Usage
Make `config/croner/hosts/[hostname]` and run task `croner:update`.

## Capistrano integration
In your `config/deploy.rb` or `Capfile` file:
```rb
require "croner/capistrano"
```

And if you want to change role, append your `config/deploy.rb` file:
```rb
croner_roles %w(web db)
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Author
[ykogure](https://github.com/ykogure)
