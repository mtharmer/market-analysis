# README

## Installation

### postgres

To install, run the following:

`$ sudo apt install postgresql`

Modify the file `/etc/postgresql/14/main/pg_hba.conf` with the following lines:
```
# Database administrative login by Unix domain socket
local   all             postgres                                trust

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
```

After saving, restart postgres:

`$ sudo systemctl restart postgresql`

And verify the database can be accessed by running

`$ psql -U postgres`


### Ruby

#### rbenv
To install rbenv locally, run the following:
```
$ sudo apt install rbenv
$ rbenv init
```

Be sure to add the recommended content to `.bashrc` and run `source ~/.bashrc` before continuing.

#### ruby-builder
The builtin `ruby-builder` is likely out of date. To install the plugin version, run the following:

`$ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build`

And to update the builder with the latest ruby versions:

`$ git -C ~/.rbenv/plugins/ruby-build pull`

#### Install Ruby

Run the following with rbenv to install the current version of Ruby:

`$ rbenv install 3.0.4`

### Gem Dependencies

Before installing dependencies, there are several `apt` packages that must be installed:

`$ sudo apt install libpg-dev libyaml-dev`

Once these are installed, all gems may be installed using bundle:

`$ bundle install`

## Running

If this is the first time the application is running, set the database using the following:

`$ rails db:reset`

Note - make sure you have created a user in postgres related to your local username, i.e.:
```
$ psql -U postgres
> create user myuser createdb;
```

Otherwise, any pending migrations can be run using:

`$ rails db:migrate`

The base application can be run by simply using:

`$ rails s`

However, the `sidekiq` must be started in another terminal using:

`$ bundle exec sidekiq -q default`

Afterwards, navigate to `localhost:3000` in a browser to use the application.

## TODO

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
