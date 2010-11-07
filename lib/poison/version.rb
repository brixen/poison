module Poison
  module VERSION
    MAJOR = 0
    MINOR = 1
    TINY  = 0
    BUILD = 'dev'

    STRING = [MAJOR, MINOR, TINY, BUILD].join('.')
  end

  def VERSION.to_s
    self::STRING
  end
end
