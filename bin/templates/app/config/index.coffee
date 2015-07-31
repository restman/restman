env = process.env.NODE_ENV || 'development'

config =
  # Development config
  development:
    app:
      name: 'dev demo'
      port: 3000

    sequelize:
      enable: false
      database: ''
      user: ''
      password: ''
      host: ''
      port: ''
      dialect: 'mysql'
      pool:
        max: 5
        min: 0
        idle: 10000

    redis:
      enable: false
      host: ''
      port: ''

    mongoose:
      enable: false
      host: ''
      port: ''
      database: ''

  # Test config
  test:
    app:
      name: 'test demo'
      port: 3000

  # Production config
  production:
    app:
      name: 'prod demo'
      port: 3000

module.exports = config[env]