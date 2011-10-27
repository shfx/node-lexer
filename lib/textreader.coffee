exports.TextReader = class TextReader
  constructor: ->
    @text = ""
    @length = 0
    @offset = 0

  read: (text) ->
    @text = text
    @length = text.length
    @offset = 0

  addOffset: (offset) ->
    @offset += offset

  reset: ->
    @offset = 0

  getText: ->
    @text.substr @offset

  EOF: ->
    @offset + 1 >= @length
