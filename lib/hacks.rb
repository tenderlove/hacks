require "hacks.so"

module Hacks
  BASIC_TYPE_LUT = Hash[constants.grep(/^T_/).map { [const_get(_1), _1] }]

  def self.basic_type obj
    BASIC_TYPE_LUT[rb_type(obj)]
  end
end
