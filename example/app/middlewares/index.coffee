test = (req, res, next) ->
  console.log "call test middleware"
  next()

module.exports = [
  test
]