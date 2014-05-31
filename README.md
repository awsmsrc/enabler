# Enabler

### Granular Feature Enabling For Ruby Apps

There are a fair few feature flip gems out there. None of them had *exactly* the feature set I needed. Most either flipped features globally or worked only on the basis of a user class. I needed to be able to switch features on for users, teams of users OR entirely different models altogether E.G companies

The goal of this gem is to enable very *granular* control of which users/teams/companies/customers/cats have access to which features. 


## Installation

Add this line to your application's Gemfile:

    gem 'enabler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enabler

## Usage

### Enable a feature

```Ruby
Enabler.enable! :new_feature, User.first
```

### Disable a feature

```Ruby
Enabler.disable! :new_feature, User.first
```

### Check if feature enabled for object

```Ruby
class NewFeatureController < ActionController::Base
  def show
    redirect_to '/home' unless Enabler.enabled? :new_feature, current_user
    render_super_secret_awesome_new_feature
  end
end
```

### Configuration

Currently there is only one storage adapter - Redis

```Ruby
Enabler.configure do
  persistence Enabler::Storage::Redis.new($redis)
  
  after_enabling :new_feature do |model|
    send_notification_email(model)
  end
  
  after_disabling :new_feature do |model|
    model.remove_feature_specific_db_records
  end
  
  rule :drive do |model|
    model.admin?
  end
end
```

#### Rules

Rules are useful if you want to set a feature globally based on an objects state.
For example enabling employee access to new features before rolling out to the public

```Ruby
Enabler.configure do
  rule :new_feature do |object|
    object.is_employee?
  end
end
```

#### Callbacks

You can define callbacks that are triggered after enabling or disabling features, this is useful fir things like sending emails or adding feature specific records to the db.

```Ruby
Enabler.configure do
  after_enabling :new_feature do |model|
    send_notification_email(model)
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
