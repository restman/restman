module.exports = (app, router) ->
  app.use '/', router

  router.get '/', (req, res, next) ->
    res.send('hello')