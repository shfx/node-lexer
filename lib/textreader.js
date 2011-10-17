var TextReader = exports.TextReader = function() {
  this.text = '';
  this.length = 0;
  this.offset = 0;
}

TextReader.prototype.read = function(text) {
  this.text = text;
  this.length = text.length;
  this.offset = 0;
}

TextReader.prototype.addOffset = function(offset) {
  this.offset += offset;
}

TextReader.prototype.reset = function() {
  this.offset = 0;
}

TextReader.prototype.getText = function() {
  return this.text.substr(this.offset);
}

TextReader.prototype.EOF = function() {
  if (this.offset + 1 >= this.length) {
    return true;
  } else {
    return false;
  }
}
