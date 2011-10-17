var EventEmitter = require('events').EventEmitter;

var TextReader = exports.TextReader = require('./textreader').TextReader;

var Lexer = exports.Lexer = function(rules) {
  EventEmitter.apply(this);
  this.rules = [];
  this.reader = new TextReader();

  for(var token in rules) {
    this.rules.push({token: token, regex: rules[token]});
  }
}

Lexer.prototype = new EventEmitter();

Lexer.prototype.tokenize = function(data) {
  this.reader.read(data);
  this.reader.reset();

  var parsedTokens = [];
  var limit = 1;

  while(!this.reader.EOF()) {
    var text = this.reader.getText();
    var matched = {};
    var tmp;

    this.rules.some(function(rule) {
      if(!(rule.regex instanceof Array)) {
        rule.regex = [ rule.regex ];
      }

      return rule.regex.some(function(regex) {
        regex.ignoreCase = true;
        if(tmp = text.match(regex)) {
          matched.text = tmp[0];
          matched.type = rule.token;
          return true;
        }
      });
    });

    if(matched.text && matched.text.length) {
      parsedTokens.push(matched);
      this.emit('token', matched);
      this.reader.addOffset(matched.text.length);
    } else {
      this.reader.addOffset(1);
    }
  }

  this.emit('end', parsedTokens);
}
