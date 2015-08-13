# Description
#   Search for emojis by keyword.
#
# Dependencies:
#   None
#
# Commands:
#   hubot emoji <keyword> - List a random emoji that matches keyword.
#   hubot emoji all <keyword> - List all emojis that match keyword.
#
# Author:
# Jeremy Mack @mutewinter

_ = require 'lodash'
emojis = require 'emojilib'

emojisForKeyword = (keyword) ->
  keyword = keyword.trim()
  matchingEmojis = _.filter(emojis, (emoji) ->
    typeof emoji is 'object' and _.include(emoji.keywords, keyword)
  )

emojiCharactersForKeyword = (keyword) ->
  _.map(emojisForKeyword(keyword), 'char')

module.exports = (robot) ->
  robot.respond /emoji (all )?(.*)/i, (msg) ->
    isAll = msg.match[1] and msg.match[2]
    keyword = msg.match[2]

    matchingEmojiCharacters = emojiCharactersForKeyword(keyword)

    if isAll
      msg.send(matchingEmojiCharacters.join(' '))
    else
      msg.send(_.sample(matchingEmojiCharacters))
