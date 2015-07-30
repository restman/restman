util = require 'util'
_    = require 'lodash'

errors = {}

errors.CODES =
  BadDigest: 400,
  BadMethod: 405,
  InvalidArgument: 409,
  InvalidContent: 400,
  InvalidCredentials: 401,
  InvalidHeader: 400,
  InvalidVersion: 400,
  MissingParameter: 409,
  NotAuthorized: 403,
  PreconditionFailed: 412,
  RequestExpired: 400,
  RequestThrottled: 429,
  ResourceNotFound: 404,
  WrongAccept: 406

_.each(_.keys(errors.CODES), (name) ->
  module.exports[name] = (message, resource, field) ->
    error = new Error message
    error.name = name
    error.resource = resource
    error.field = field
    error.statusCode = errors.CODES[name]
    error
)






