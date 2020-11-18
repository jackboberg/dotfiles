#!/usr/bin/env ruby

# improved printing
begin
  require 'amazing_print'
  AmazingPrint.pry!
rescue LoadError => e
  warn "Couldn't load amazing_print: #{e}"
end

# add ability to disable pry with ENV
Pry.hooks.add_hook(:when_started, 'disable_pry') do
  exit if ENV['DEBUG'] == '0'
end
