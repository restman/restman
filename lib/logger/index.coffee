'use strict'

winston = require 'winston'
_       = require 'underscore'

module.exports = (opts) ->

  loggerInit = (opts, logger, logName = 'logger') ->
    if opts.ENV is 'development'
      options =
        colorize: true
        timestamp: true
        prettyPrint: true
      logger.add(winston.transports.Console, options)
    else
      options =
        filename: opts.logPath + logName + '.log'
      logger.add(winston.transports.File, options)

  logger = new winston.Logger
  loggerInit(opts, logger)

  instanceCache = {}
  logger.createNewLogger = (logName) ->
    newlogger = {}
    if _.has(instanceCache, logName)
      newLogger = instanceCache[logName]
    else
      newlogger = new winston.Logger
      loggerInit(opts logger, logName)
    newlogger

  logger
