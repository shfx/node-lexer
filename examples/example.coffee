Lexer = require('../main').Lexer;

tokens =
  words:       /^[a-z]+/i,
  whitespaces: /^[ ]+/,
  numbers:     /^\d+/,
  string: [
    /^".*?[^\\]"/,
    /^'.*?[^\\]'/
  ]

lex = new Lexer(tokens);

lex.on 'token', (token) -> console.log(token)
lex.on 'end', () -> console.log('End parsing')
lex.tokenize 'test 123 "le puff"'
