EventEmitter = require("events").EventEmitter
TextReader = exports.TextReader = require("./textreader").TextReader
Lexer = exports.Lexer = (rules) ->
  EventEmitter.apply this
  @rules = []
  @reader = new TextReader()
  for token of rules
    @rules.push
      token: token
      regex: rules[token]

Lexer:: = new EventEmitter()
Lexer::tokenize = (data) ->
  @reader.read data
  @reader.reset()
  parsedTokens = []
  limit = 1
  until @reader.EOF()
    text = @reader.getText()
    matched = {}
    tmp = undefined
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
