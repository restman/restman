mongoose = require 'mongoose'

module.exports = (config) ->
  opts = config.mongoose
  return unless opts.enable
  mongoose.connect('mongodb://' + opts.host + ':' + opts.port + '/' + opts.database)
  mongoose
