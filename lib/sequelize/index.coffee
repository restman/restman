'use strict'

Sequelize = require 'sequelize'

module.exports = (config) ->
  if config.sequelize.enable

    options =
      dialect: config.sequelize.dialect
      pool: config.sequelize.pool

    sequelize = new Sequelize(config.sequelize.db, config.sequelize.username, config.sequelize.password, options)

  sequelize
