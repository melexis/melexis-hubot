# Feel hurt when an exception occurs
#
# Say 'aie' when a message contains 'exception'
#
#

Util = require "util"

today = () ->
  date = new Date()
  date.toJSON().split(/T/)[0]

incrementCounter = (data, cat, key) ->
  counters = data[cat] ? { }
  if counters[key]?
    counters[key]++
  else
    counters[key] = 1
  data[cat] = counters

module.exports = (robot) ->
  robot.respond /(.*) (.*exception)(.*)/i, (msg) ->
    msg.send "Aie! : Got a #{msg.match[2]} from #{msg.match[1]} complaining about #{msg.match[3]}"
    key = "exceptions_#{today()}"

    data = robot.brain.data[key] ? {}

    data.total += 1

    incrementCounter data, 'sources', msg.match[1]
    incrementCounter data, 'exceptions', msg.match[2]
    incrementCounter data, 'causes', msg.match[3]

    icrementCounter(data, 'tags', tag) for tag in msg.tags ? []

    robot.brain.data[key] = data