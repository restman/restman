'use strict'

# Module dependencies
express             = require 'express'
glob                = require 'glob'
morgan              = require 'morgan'
cookieParser        = require 'cookie-parser'
bodyParser          = require 'body-parser'
methodOverride      = require 'method-override'
responseTime        = require 'response-time'
winston             = require 'winston'

error               = require './error'

# Expose `application()`
module.exports = (opts) ->

  # Init express
  app = express()

  # Set env
  app.locals.ENV = opts.ENV

  # Disable x-powered-by
  app.set 'x-powered-by', false

  # Use morgan write access log
  if opts.ENV is 'development'
    app.use morgan 'dev'
  else
    logger = new winston.Logger()
    logger.add(winston.transports.DailyRotateFile, filename: opts.logPath + '/access.log')
    logger.write = (message, encoding) ->
      logger.info(message)
    app.use morgan('combined', stream: logger)

  # Load middle-ware
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(
    extended: true
  )
  app.use cookieParser()
  app.use methodOverride()
  app.use responseTime()

  # Load controllers
  controllers = glob.sync opts.controllerPath + '/**/*.coffee'
  controllers.forEach (controllerPath) ->
    router = express.Router()
    require(controllerPath)(app, router)

  # catch 404 and forward to error handler
  app.use (req, res, next) ->
    err = new Error 'not found'
    next err

  # ErrorHandler
  app.use error.errorHandler

  # Return app
  app
