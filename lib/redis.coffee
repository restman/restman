redis = require 'redis'

module.exports = (config) ->
  opts = config.redis
  return unless opts.enable
  redis.createClient(opts.port, opts.host)
