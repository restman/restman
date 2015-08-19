_ = require 'lodash'

cache = {}

cache.isExistNS = (namespace) ->
  return false unless _.isString(namespace)
  return false unless _.has(cache.keyMap, namespace)
  return true

cache.unionKey = (namespace, key) ->
  key + '_' + namespace

cache.set = (namespace, key, value) ->
  return new Error('key must string type') unless _.isString(key)
  return new Error('namespace not exist') unless cache.isExistNS(namespace)
  unionKey = cache.unionKey(namespace, key)
  value = _.omit(value, _.isFunction) if _.isObject(value)
  value = JSON.stringify(value)
  if cache.keyMap[namespace]
    cache.redis.setex(unionKey, cache.keyMap[namespace], value)
  else
    cache.redis.set(unionKey, value)

cache.get = (namespace, key, cb) ->
  return new Error('key must string type') unless _.isString(key)
  return new Error('namespace not exist') unless cache.isExistNS(namespace)
  unionKey = cache.unionKey(namespace, key)
  cache.redis.get unionKey, (err, result) ->
    result = JSON.parse(result) unless err
    cb(err, result)

cache.del = (namespace, key, cb) ->
  return new Error('key must string type') unless _.isString(key)
  return new Error('namespace not exist') unless cache.isExistNS(namespace)
  unionKey = cache.unionKey(namespace, key)
  cache.redis.del(unionKey, cb)

cache.incr = (namespace, key, cb) ->
  return new Error('key must string type') unless _.isString(key)
  return new Error('namespace not exist') unless cache.isExistNS(namespace)
  unionKey = cache.unionKey(namespace, key)
  cache.redis.incr(unionKey, cb)

cache.decr = (namespace, key, cb) ->
  return new Error('key must string type') unless _.isString(key)
  return new Error('namespace not exist') unless cache.isExistNS(namespace)
  unionKey = cache.unionKey(namespace, key)
  cache.redis.decr(unionKey, cb)


module.exports = (redis, opts) ->
  cache.redis = redis
  cache.keyMap = require opts.configPath + '/cache'
  cache

