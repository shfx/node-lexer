var Lexer = require('../main').Lexer;

var tokens = {
  words:       /^[a-z]+/i,
  whitespaces: /^[ ]+/,
  numbers:     /^\d+/,
  string: [
    /^".*?[^\\]"/,
    /^'.*?[^\\]'/
  ]
}

var lex = new Lexer(tokens);

lex.on('token', function(token){
  console.log(token);
});

lex.on('end', function(){
  console.log('End parsing');
})

lex.tokenize('test 123 "le puff"');
