'use strict'

mongoose = require 'mongoose'

module.exports = (config) ->
  if config.mongoose.enable
    mongoose.connect('mongodb://' + config.mongoose.host + ':' + config.mongoose.port + '/' + config.mongoose.db)
  mongoose