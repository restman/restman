app = require('../../index').app
request = require('supertest')(app)

describe 'Home', ->
  describe 'Get /', ->
    it 'respond with json', (done) ->
      request
        .get '/'
        .expect message: 'Hello World!'
        .expect 200, (err, res) ->
          res.should.be.json
          done err
