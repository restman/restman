'use strict'

# Module dependencies
application     = require './application'
config          = require './config'
helper          = require './helper'
utils           = require './utils'
mongoose        = require './mongoose'
sequelize       = require './sequelize'
redis           = require './redis'
logger          = require './logger'

restman = {}

# construct `opts`
opts = (rootPath) ->
  ENV: process.env.NODE_ENV || 'development'
  rootPath: rootPath
  configPath: "#{rootPath}/app/config"
  controllerPath: "#{rootPath}/app/controllers"
  modelPath: "#{rootPath}/app/models"
  logPath: "#{rootPath}/logs"
  testPath: "#{rootPath}/test"


# Expose `restman`
module.exports = restman

# Expose `restman.bootstrap`
module.exports.bootstrap = (rootPath) ->
  restman.opts = opts(rootPath)
  restman.config = config(restman.opts)
  restman.app = application(restman.opts)
  restman.logger = logger(restman.opts)
  restman.mongoose = mongoose(restman.config)
  restman.sequelize = sequelize(restman.config)
  restman.redis = redis(restman.config)
  restman.helper = helper
  restman.utils = utils
  restman

# Expose `restman.start`
module.exports.start = ->
  restman.app.listen restman.config.app.port
