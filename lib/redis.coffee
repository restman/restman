Redis = require 'ioredis'

module.exports = (config) ->
  opts = config.redis
  return unless opts.enable
  redis = new Redis(opts.port, opts.host)
  redis
