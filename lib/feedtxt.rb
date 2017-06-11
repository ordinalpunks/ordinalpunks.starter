# encoding: utf-8


# core and stdlibs

require 'json'
require 'yaml'
require 'date'
require 'time'
require 'pp'


# 3rd party gems/libs
require 'logutils'


# our own code
require 'feedtxt/version'  # let it always go first
require 'feedtxt/parser'




# say hello
puts Feedtxt.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
