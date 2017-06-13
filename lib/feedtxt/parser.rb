# encoding: utf-8

module Feedtxt


class Parser

  include LogUtils::Logging


  ### convenience class/factory method
  def self.parse( text, opts={} )
    self.new( text ).parse
  end

  ### Note: lets keep/use same API as RSS::Parser for now
  def initialize( text )
    @text = text
  end


  def parse
    ## auto-detect format
    ##   use "best" matching format (e.g. first match by pos(ition))

    klass = YamlParser
    pos   = 9999999

    json = @text.index( /#{JsonParser::FEED_BEGIN}/ )
    if json    # found e.g. not nil? incl. 0
      pos   = json
      klass = JsonParser
    end

    yaml = @text.index( /#{YamlParser::FEED_BEGIN}/ )
    if yaml && yaml < pos  # found e.g. not nil? and match before last?
      pos   = yaml
      klass = YamlParser
    end

    feed = klass.parse( @text )
    feed
  end # method parse

end  # class Parser

end # module Feedtxt
