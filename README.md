# Enabler

There are a fair few feature flip gems out there. None of them had *exactly* the feature set I needed. Most either flipped features globally or worked only on the basis of a user class. I needed to be able to switch features on for users, teams of users OR entirely different models altogether E.G Company

The goal of this gem is to enable very *granular* control of which users/teams/companies/customers/cats have access to which features. 


## Installation

Add this line to your application's Gemfile:

    gem 'enabler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enabler

## Usage

### Configuration

Currently there is only one storage adapter - Redis

```Ruby
Enabler.store = Enabler::Storage::Redis.new($redis)
```

### Rules

```Ruby
Enabler.define_rule! :dance do |object|
  object.is_cool?
end
```

### Specific Models

```Ruby
Enabler.enable! :dance, User.first
```

### Check if feature enabled for object

```Ruby
class NewFeatureController < ActionController::Base
  def show
    redirect_to '/home' unless Enabler.enabled? :new_feature, current_user
  end
end
```



## TODO
* caching
* group definitions
* rake task to add feature for percentage of users
* ActiveRecord storage
* Mongo storage
* In memory storage


## Contributing

1. Fork it ( https://github.com/[my-github-username]/enabler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
