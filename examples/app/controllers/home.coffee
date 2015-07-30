restman = require "../../../"
module.exports = (app, router) ->

  app.use '/', router

  router.get '/', (req, res, next) ->
    res.send "hello"

  router.get '/error', (req, res, next) ->
    next restman.errors.BadMethod('111', '222', '3333')
