'use strict'

application     = require './application'
config          = require './config'
helper          = require './helper'
utils           = require './utils'
mongoose        = require './mongoose'
sequelize       = require './sequelize'
redis           = require './redis'

restman = {}

workspace = (workspacePath) ->
  configPath: "#{workspacePath}/app/config"
  controllerPath: "#{workspacePath}/app/controllers"
  modelPath: "#{workspacePath}/app/models"
  logPath: "#{workspacePath}/logs"
  testPath: "#{workspacePath}/test"

module.exports = restman

module.exports.bootstrap = (workspacePath) ->
  restman.workspace = workspace(workspacePath)
  restman.config = config(restman.workspace)
  restman.app = application(restman.workspace)
  restman.mongoose = mongoose(restman.config)
  restman.sequelize = sequelize(restman.config)
  restman.redis = redis(restman.config)
  restman.helper = helper
  restman.utils = utils

module.exports.start = ->
  restman.app.listen restman.config.app.port
