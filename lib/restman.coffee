# Module dependencies
_       = require 'lodash'
app     = require 'restman-app'
errors  = require 'restman-errors'
queue   = require 'restman-queue'
utils   = require 'restman-utils'
config  = require 'restman-config'
cache   = require 'restman-cache'
logger  = require 'restman-logger'

restman = {}

# construct `opts`
opts = (rootPath) ->
  ENV: process.env.NODE_ENV || 'development'
  rootPath: rootPath
  configPath: "#{rootPath}/app/config"
  controllerPath: "#{rootPath}/app/controllers"
  modelPath: "#{rootPath}/app/models"
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

  if restman.config.has 'queue'
    restman.queue   = queue(restman.config.get('queue.opts'))

  if restman.config.has 'cache'
    restman.cache   = cache(restman.config.get('cache.opts'), restman.config.get('cache.namespaceMap'))

  restman

# Expose `restman.app.start`
restman.start = ->
  restman.app = app(restman.opts)
  restman.app.listen restman.config.get('app.port'), '0.0.0.0'
  console.log "restman-app listening at http://0.0.0.0:#{restman.config.get('app.port')}"

# Expose `restman`
module.exports = restman
