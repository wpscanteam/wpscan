# frozen_string_literal: true

# Hack of the Numeric class
class Numeric
  # @return [ String ] A human readable string of the value
  def bytes_to_human
    units = %w[B KB MB GB TB]
    e     = abs.zero? ? abs : (Math.log(abs) / Math.log(1024)).floor
    s     = format('%<s>.3f', s: (abs.to_f / (1024**e)))

    s.sub(/\.?0*$/, " #{units[e]}")
  end
end
