{EventEmitter} = require("events")
{TextReader}   = require("./textreader")

exports.Lexer = class Lexer extends EventEmitter
  constructor: (rules) ->
    @rules = []
    @reader = new TextReader()

    for token of rules
      @rules.push
        token: token
        regex: rules[token]

  tokenize: (data) ->
    @reader.read data
    @reader.reset()
    parsedTokens = []

    until @reader.EOF()
      text = @reader.getText()
      matched = {}
      tmp = null
      @rules.some (rule) ->
        rule.regex = [ rule.regex ]  unless rule.regex instanceof Array
        rule.regex.some (regex) ->
          regex.ignoreCase = true
          if tmp = text.match(regex)
            matched.text = tmp[0]
            matched.type = rule.token
            true

      if matched.text and matched.text.length
        parsedTokens.push matched
        @emit "token", matched
        @reader.addOffset matched.text.length
      else
        @reader.addOffset 1
    @emit "end", parsedTokens
