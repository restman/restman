# Module dependencies
path    = require 'path'
_       = require 'lodash'
glob    = require 'glob'
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
  helperPath: "#{rootPath}/app/helpers"
  workerPath: "#{rootPath}/app/workers"
  handlerPath: "#{rootPath}/app/handlers"
  middlewarePath: "#{rootPath}/app/middlewares"
  logPath: "#{rootPath}/logs"
  testPath: "#{rootPath}/test"

loadModule = (modulePath, suffix = '') ->
  modules = {}
  filepaths = glob.sync "#{modulePath}/**/*.coffee", ignore:['./index.coffee']
  for filepath in filepaths
    fileName = path.basename filepath, '.coffee'
    moduleName = _.camelCase fileName
    modules["#{moduleName}#{suffix}"] = require filepath
  return modules

# Expose `restman.bootstrap`
restman.bootstrap = (rootPath) ->
  restman.opts      = opts(rootPath)
  restman.config    = config(restman.opts.configPath)
  restman.logger    = logger(restman.opts.logPath)
  restman.models    = loadModule(restman.opts.modelPath, 'Model')
  restman.helpers   = loadModule(restman.opts.helperPath, 'Helper')
  restman.workers   = loadModule(restman.opts.workerPath, 'Worker')
  restman.handlers  = loadModule(restman.opts.handlers, 'Handler')
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
