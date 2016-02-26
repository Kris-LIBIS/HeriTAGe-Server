#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path('../config/boot.rb', __FILE__)

use Rack::Config do |env|
  env['api.tilt.root'] = Padrino.root('/api/views')
end

run Padrino.application
