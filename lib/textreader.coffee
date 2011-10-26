TextReader = exports.TextReader = ->
  @text = ""
  @length = 0
  @offset = 0

TextReader::read = (text) ->
  @text = text
  @length = text.length
  @offset = 0

TextReader::addOffset = (offset) ->
  @offset += offset

TextReader::reset = ->
  @offset = 0

TextReader::getText = ->
  @text.substr @offset

TextReader::EOF = ->
  @offset + 1 >= @length
