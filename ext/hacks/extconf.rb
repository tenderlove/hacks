require "mkmf"
require "erb"

constants = %w{
    RUBY_T_NONE

    RUBY_T_OBJECT
    RUBY_T_CLASS
    RUBY_T_MODULE
    RUBY_T_FLOAT
    RUBY_T_STRING
    RUBY_T_REGEXP
    RUBY_T_ARRAY
    RUBY_T_HASH
    RUBY_T_STRUCT
    RUBY_T_BIGNUM
    RUBY_T_FILE
    RUBY_T_DATA
    RUBY_T_MATCH
    RUBY_T_COMPLEX
    RUBY_T_RATIONAL

    RUBY_T_NIL
    RUBY_T_TRUE
    RUBY_T_FALSE
    RUBY_T_SYMBOL
    RUBY_T_FIXNUM
    RUBY_T_UNDEF

    RUBY_T_IMEMO
    RUBY_T_NODE
    RUBY_T_ICLASS
    RUBY_T_ZOMBIE
    RUBY_T_MOVED

    RUBY_T_MASK
    RUBY_Qfalse
    RUBY_Qnil
    RUBY_Qtrue
    RUBY_Qundef
    RUBY_IMMEDIATE_MASK
    RUBY_FIXNUM_FLAG
    RUBY_FLONUM_MASK
    RUBY_FLONUM_FLAG
    RUBY_SYMBOL_FLAG
}

def make_c constants
  erb_file = File.join File.dirname(__FILE__), "hacks.c.erb"
  erb = ERB.new(File.binread(erb_file), trim_mode: "-")
  c = erb.result(binding)
  c_file = File.join File.dirname(__FILE__), "hacks.c"
  File.binwrite c_file, c
end

make_c constants.find_all { have_const(_1) }.map { [_1.sub(/^RUBY_/, ''), _1] }

create_makefile "hacks"
