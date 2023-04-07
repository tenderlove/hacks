require "mkmf"
require "erb"

require File.join File.dirname(__FILE__), "constants.rb"
require File.join File.dirname(__FILE__), "structs.rb"
require File.join File.dirname(__FILE__), "function_pointers.rb"

def make_c constants, structs, fps
  erb_file = File.join File.dirname(__FILE__), "hacks.c.erb"
  erb = ERB.new(File.binread(erb_file), trim_mode: "-")
  c = erb.result(binding)
  c_file = File.join File.dirname(__FILE__), "hacks.c"
  File.binwrite c_file, c
end

constants = Hacks::CONSTANTS.find_all {
  have_const(_1)
}.map {
  [_1.sub(/^RUBY_/, ''), _1]
}

make_c constants, Hacks::STRUCTS, Hacks::FPs

create_makefile "hacks"
