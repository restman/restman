'use strict'

application     = require './application'
config          = require './config'

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





module.exports.start = ->
  restman.app.listen(restman.config)
