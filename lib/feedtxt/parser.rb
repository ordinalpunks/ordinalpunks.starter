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



  FEED_BEGIN_RX = %r{^\|>>>$}
  FEED_END_RX   = %r{^<<<\|$}
  FEED_NEXT_RX  = %r{^</>$}       ## pass 1: split/break up blocks
  FEED_META_RX  = %r{^---$}       ## pass 2: break up item into metadata and content block


  def parse

    ## find start marker e.g. |>>>
    ##    todo: use regex - allow three or more >>>>>> or <<<<<<
    ##    todo: allow spaces before and after


    ## todo/fix:
    ##    use index-like finder return posbeg and posend!!!
    ##      regex is not fixed length/width; we need to know the length
    ##   check what is the best way?  use regex match or something???

    posbeg = @text.index( FEED_BEGIN_RX )
    if posbeg.nil?
      ## nothing found return empty array for now; return nil - why? why not?
      puts "warn !!! no begin marker found e.g. |>>>"
      return []
    end

    posend = @text.index( FEED_END_RX, posbeg )
    if posend.nil?
      ## nothing found return empty array for now; return nil - why? why not?
      puts "warn !!! no end marker found e.g. <<<|"
      return []
    end

    ## cutoff - get text between begin and end marker
    buf = @text[ posbeg+4...posend ].strip
    ## pp buf

    ####
    ## pass 1: split blocks by </>
    ###    todo: allow   <<<</>>>>

    blocks = buf.split( FEED_NEXT_RX )
    ## pp blocks

    ## 1st block is feed meta data
    block1st = blocks.shift       ## get/remove 1st block from blocks
    feed_metadata = YAML.load( block1st.strip )

    feed_items = []
    blocks.each do |block|
      ###   note: do NOT use split e.g.--- is used by markdown
      ##      only search for first --- to split (all others get ignored)
      ##    todo: make three dashes --- (3) not hard-coded (allow more)
      posmeta = block.index( FEED_META_RX )
      item = []
      item[0] = block[0...posmeta].strip
      item[1] = block[posmeta+3..-1].strip

      item_metadata = YAML.load( item[0] )
      item_content  = item[1]

      feed_items << [item_metadata, item_content]
    end

    [ feed_metadata, feed_items ]
  end # method parse


end  # class Parser
end # module Feedtxt
