'use strict'

redis = require 'redis'

module.exports = (config) ->
  if config.redis.enable
    client = redis.createClient(config.redis.port, config.redis.host)

  client
