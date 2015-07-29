'use strict'

winston = require 'winston'

module.exports = (opts) ->
  logger = new winston.Logger
  if opts.ENV is 'development'
    options =
      colorize: true
      timestamp: true
      prettyPrint: true
    logger.add(winston.transports.Console, options)
  else
    options =
      filename: opts.logPath + 'logger.log'
    logger.add(winston.transports.File, options)
  logger

