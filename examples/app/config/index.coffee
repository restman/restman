env = process.env.NODE_ENV || 'development'

config =
  development:
    app:
      name: 'dev demo'
    port: 3000

  test:
    app:
      name: 'test demo'
    port: 3000

  production:
    app:
      name: 'prod demo'
    port: 3000

module.exports = config[env]
