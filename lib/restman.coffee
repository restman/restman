# Module dependencies
_       = require 'lodash'
app     = require 'restman-app'
errors  = require 'restman-errors'
utils   = require 'restman-utils'
config  = require 'restman-config'
logger  = require 'restman-logger'

restman = {}

# construct `opts`
opts = (rootPath) ->
  ENV: process.env.NODE_ENV || 'development'
  rootPath: rootPath
  configPath: "#{rootPath}/app/config"
  controllerPath: "#{rootPath}/app/controllers"
  middlewarePath: "#{rootPath}/app/middlewares"
  logPath: "#{rootPath}/logs"
  testPath: "#{rootPath}/test"

# Expose `restman.bootstrap`
restman.bootstrap = (rootPath) ->
  restman.opts      = opts(rootPath)
  restman.config    = config(restman.opts.configPath)
  restman.logger    = logger(restman.opts.logPath)
  restman.errors    = errors
  restman.utils     = utils

  restman

# Expose `restman.load`
restman.load = (name, module) ->
  restman[name] = module

# Expose `restman.start`
restman.start = ->
  restman.app = app(restman.opts)
  restman.app.listen restman.config.get('app.port'), '0.0.0.0'
  console.log "restman-app listening at http://0.0.0.0:#{restman.config.get('app.port')}"

# Expose `restman`
module.exports = restman
