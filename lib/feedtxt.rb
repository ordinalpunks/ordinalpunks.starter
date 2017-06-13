# encoding: utf-8


# core and stdlibs

require 'strscan'    ## StringScanner
require 'json'
require 'yaml'
require 'date'
require 'time'
require 'pp'



# 3rd party gems/libs
require 'logutils'
require 'props'     ## used for IniFile.parse


# our own code
require 'feedtxt/version'  # let it always go first
require 'feedtxt/parser'
require 'feedtxt/parser/json'
require 'feedtxt/parser/yaml'
require 'feedtxt/parser/ini'



##  add shortcut / alias e.g.
##   lets you use:
##    Feedtxt.parse  instead of Feedtxt::Parser.parse
module Feedtxt
  def self.parse( text, opts={} )
    Parser.parse( text,  )
  end
end



# say hello
puts Feedtxt.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
