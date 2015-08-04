app = require('../../index').app
request = require('supertest')(app)

describe 'Home', ->
  describe 'Get /', ->
    it 'respond with json', ->
      request
        .get '/'
        .expect 'Content-Type', /json/
        .expect 200, (err, res) ->
          res.should.be.json
          res.should.eql message: 'Hello World!'
