#!/bin/bash
bundle exec rake db:create  RAILS_ENV=development
bundle exec rake db:migrate RAILS_ENV=development
