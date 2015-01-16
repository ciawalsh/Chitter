require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost:15432/chitter_#{env}")

require './lib/user'
require './lib/peep'
require './helpers/user_application'

DataMapper.finalize
DataMapper.auto_upgrade!
