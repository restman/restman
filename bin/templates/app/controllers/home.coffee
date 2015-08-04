restman = require 'restman'

module.exports = (app, router) ->

  app.use '/', router

  router.get '/', (req, res, next) ->
    res.json message: 'Hello World!'

  router.get '/error', (req, res, next) ->
    next restman.errors.BadMethod('111', '222', '3333')
