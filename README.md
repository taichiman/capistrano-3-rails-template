# Capistrano 3 Rails Config

## Overview

This is a sample configuration for deploying Ruby on Rails applications.

## Usage

See
<http://www.talkingquickly.co.uk/2014/01/deploying-rails-apps-to-a-vps-with-capistrano-v3/>
for a tutorial on usage.

Or for more details, this is also the example configuration used in the
book Reliably Deploying Rails Applications available on Leanpub:
<https://leanpub.com/deploying_rails_applications>


##Deploy:

  Gems:

    Gemfile:
      gem 'capistrano-rails','~> 1.1.0'
      gem 'capistrano-rvm'
      gem 'capistrano-bundler'

    Gemfile.lock
      capistrano (3.1.0)
      capistrano-bundler (1.1.1)
      capistrano-rails (1.1.1)
      capistrano-rvm (0.1.1)

  ssh:
  create user on server
  create folder: www
  set access rw for user and user's group
  create symlinks for shared/config files by manual

  cap staging deploy
  cap staging deploy:setup_config

##Path TODO:
  .clean files
  .check work for latest gem version