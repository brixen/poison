module Poison
  class SyntaxError < Exception
  end

  class Syntax < Node

    class Boolean < Node
    end

    class NilKind < Node
    end

    class Message < Node
    end
  end
end
