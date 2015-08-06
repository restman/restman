Sequelize = require 'sequelize'

module.exports = (config) ->
  opts = config.sequelize
  return unless opts.enable
  options =
    dialect: opts.dialect
    pool: opts.pool
  new Sequelize(opts.database, opts.user, opts.password, options)
