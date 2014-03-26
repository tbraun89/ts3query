module TS3Query
  module Escaping
    # http://media.teamspeak.com/ts3_literature/TeamSpeak%203%20Server%20Query%20Manual.pdf
    # Page 5
    DecodePatterns = {
    '\\\\' => "\\",  # Backslash
      '\/' => "/",   # Slash
      '\s' => " ",   # Whitespace
      '\p' => "|",   # Pipe
      '\a' => "\a",  # Bell
      '\b' => "\b",  # Backspace
      '\f' => "\f",  # Formfeed
      '\n' => "\n",  # Newline
      '\r' => "\r",  # Carriage Return
      '\t' => "\t",  # Horizontal Tab
      '\v' => "\v",  # Vertical Tab
    }
    EncodePatterns = DecodePatterns.invert
    EncodeRegexp = /[#{Regexp.escape DecodePatterns.values.join}]/
    DecodeRegexp = /\\[#{Regexp.escape DecodePatterns.keys.map{|k|k[1]}.join}]/

    def self.encode str
      str.gsub EncodeRegexp, DecodePatterns
    end

    def self.decode str
      str.gsub DecodeRegexp, DecodePatterns
    end

  end
end

# TS3Query::Escaping.encode "hello world"
# TS3Query::Escaping.decode "hello\sworld\p\a\n\nhi\v"
