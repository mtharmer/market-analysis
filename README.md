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

### Javascript

Get the `nvm` manager installer:

`$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash`

Copy the output lines into `.bashrc`:
```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

After saving, run `source ~/.bashrc` to reload the session.

Next, install the desired version of Node along with yarn:
```
$ nvm install v18
$ nvm use v18
$ npm install -g yarn
```

Then, in the repository, run:

`$ yarn install`

And finally, compile the stylesheets using:

`$ rails assets:precompile`

### Redis

Redis may be out of date with the gems. If so, we can pull the download:
```
$ wget https://github.com/redis/redis/archive/7.2.4.tar.gz
$ tar -xzf redis-7.2.4.tar.gz
$ cd redis-7.2.4/
$ make
$ make install
$ sudo mkdir -p /etc/redis
$ sudo cp redis.conf /etc/redis/redis.conf
$ sudo touch /lib/systemd/redis-server.service
```

Fill the redis service file with contents similar to this:

```
[Unit]
Description=Redis
After=syslog.target

[Service]
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
RestartSec=5s
Restart=on-success

[Install]
WantedBy=multi-user.target
```

Finally, create symlinks and start the service:

```
$ cd /etc/systemd
$ sudo ln -s /lib/systemd/redis-server.service redis-server.service
$ sudo ln -s /lib/systemd/redis-server.service redis.service
$ sudo systemctl start redis
```

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
