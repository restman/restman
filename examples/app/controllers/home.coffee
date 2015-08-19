restman = require "../../../"
cache = restman.cache

module.exports = (app, router) ->

  app.use '/', router

  router.get '/', (req, res, next) ->
    res.send "hello"

  router.get '/error', (req, res, next) ->
    next restman.errors.BadMethod('message', 'resource', 'field')

  router.get '/get_cache', (req, res, next) ->
    cache.get 'test', 'key', (err, result) ->
      res.send result

  router.get '/set_cache', (req, res, next) ->
    res.send(cache.set 'test', 'key', key:'value')