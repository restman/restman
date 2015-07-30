util = require 'util'
_    = require 'lodash'

errors = {}

errors.CODES =
  BadRequest: 400,
  InvalidContent: 400,
  InvalidHeader: 400,
  UnAuthorized: 401,
  Forbidden: 403,
  ResourceNotFound: 404,
  BadMethod: 405,
  RequestTimeout: 408,
  InvalidArgument: 409,
  MissingParameter: 409,
  LengthRequired: 411,
  UnprocessableEntity: 422,
  Internal: 500

_.each(_.keys(errors.CODES), (name) ->
  module.exports[name] = (message, resource, field) ->
    error = new Error message
    error.name = name
    error.resource = resource
    error.field = field
    error.statusCode = errors.CODES[name]
    error
)
