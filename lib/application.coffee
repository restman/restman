'use strict'

express         = require 'express'
glob            = require 'glob'
logger          = require 'morgan'
cookieParser    = require 'cookie-parser'
bodyParser      = require 'body-parser'
methodOverride  = require 'method-override'
responseTime    = require 'response-time'

module.exports = (workspace) ->

  app = express()

  app.set 'x-powered-by', false

  app.use logger 'dev'
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(
    extended: true
  )
  app.use cookieParser()
  app.use methodOverride()
  app.use responseTime()


  controllers = glob.sync workspace.controllerPath + '/**/*.coffee'
  controllers.forEach (controllerPath) ->
    router = express.Router()
    require(controllerPath)(app, router)

  # catch 404 and forward to error handler
  app.use (req, res, next) ->
    err = new Error 'Not Found'
    err.status = 404
    next err
  app





