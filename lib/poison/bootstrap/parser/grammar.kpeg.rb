require 'kpeg/compiled_parser'

class Poison::Parser < KPeg::CompiledParser
  # :stopdoc:

  # root = statements:s end-of-file { s }
  def _root

    _save = self.pos
    while true # sequence
      _tmp = apply(:_statements)
      s = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_end_hyphen_of_hyphen_file)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  s ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_root unless _tmp
    return _tmp
  end

  # statements = .
  def _statements
    _tmp = get_byte
    set_failed_rule :_statements unless _tmp
    return _tmp
  end

  # end-of-file = !.
  def _end_hyphen_of_hyphen_file
    _save = self.pos
    _tmp = get_byte
    _tmp = _tmp ? nil : true
    self.pos = _save
    set_failed_rule :_end_hyphen_of_hyphen_file unless _tmp
    return _tmp
  end

  # utfw = (/[A-Za-z0-9_$@;`{}]/ | "\\304" /[\250-\277]/ | /[\305-\337]/ /[\200-\277]/ | /[\340-\357]/ /[\200-\277]/ /[\200-\277]/ | /[\360-\364]/ /[\200-\277]/ /[\200-\277]/ /[\200-\277]/)
  def _utfw

    _save = self.pos
    while true # choice
      _tmp = scan(/\A(?-mix:[A-Za-z0-9_$@;`{}])/)
      break if _tmp
      self.pos = _save

      _save1 = self.pos
      while true # sequence
        _tmp = match_string("\\304")
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = scan(/\A(?-mix:[\250-\277])/)
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save2 = self.pos
      while true # sequence
        _tmp = scan(/\A(?-mix:[\305-\337])/)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save3 = self.pos
      while true # sequence
        _tmp = scan(/\A(?-mix:[\340-\357])/)
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save4 = self.pos
      while true # sequence
        _tmp = scan(/\A(?-mix:[\360-\364])/)
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_utfw unless _tmp
    return _tmp
  end

  # utf8 = (/[\t\n\r\40-\176]/ | /[\302-\337]/ /[\200-\277]/ | /[\340-\357]/ /[\200-\277]/ /[\200-\277]/ | /[\360-\364]/ /[\200-\277]/ /[\200-\277]/ /[\200-\277]/)
  def _utf8

    _save = self.pos
    while true # choice
      _tmp = scan(/\A(?-mix:[\t\n\r\40-\176])/)
      break if _tmp
      self.pos = _save

      _save1 = self.pos
      while true # sequence
        _tmp = scan(/\A(?-mix:[\302-\337])/)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save2 = self.pos
      while true # sequence
        _tmp = scan(/\A(?-mix:[\340-\357])/)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save3 = self.pos
      while true # sequence
        _tmp = scan(/\A(?-mix:[\360-\364])/)
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = scan(/\A(?-mix:[\200-\277])/)
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_utf8 unless _tmp
    return _tmp
  end

  # nil = "nil" !utfw
  def _nil

    _save = self.pos
    while true # sequence
      _tmp = match_string("nil")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_utfw)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_nil unless _tmp
    return _tmp
  end

  # true = "true" !utfw
  def _true

    _save = self.pos
    while true # sequence
      _tmp = match_string("true")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_utfw)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_true unless _tmp
    return _tmp
  end

  # false = "false" !utfw
  def _false

    _save = self.pos
    while true # sequence
      _tmp = match_string("false")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_utfw)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_false unless _tmp
    return _tmp
  end

  # hexl = /[0-9A-Fa-f]/
  def _hexl
    _tmp = scan(/\A(?-mix:[0-9A-Fa-f])/)
    set_failed_rule :_hexl unless _tmp
    return _tmp
  end

  # hex = "0x" < hexl+ >
  def _hex

    _save = self.pos
    while true # sequence
      _tmp = match_string("0x")
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      _save1 = self.pos
      _tmp = apply(:_hexl)
      if _tmp
        while true
          _tmp = apply(:_hexl)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_hex unless _tmp
    return _tmp
  end

  # digits = ("0" | /[1-9]/ /[0-9]*/)
  def _digits

    _save = self.pos
    while true # choice
      _tmp = match_string("0")
      break if _tmp
      self.pos = _save

      _save1 = self.pos
      while true # sequence
        _tmp = scan(/\A(?-mix:[1-9])/)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = scan(/\A(?-mix:[0-9]*)/)
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_digits unless _tmp
    return _tmp
  end

  # int = < digits >
  def _int
    _text_start = self.pos
    _tmp = apply(:_digits)
    if _tmp
      text = get_text(_text_start)
    end
    set_failed_rule :_int unless _tmp
    return _tmp
  end

  # real = < digits "." digits ("e" /[-+]?/ /[0-9]+/)? >
  def _real
    _text_start = self.pos

    _save = self.pos
    while true # sequence
      _tmp = apply(:_digits)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(".")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_digits)
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = match_string("e")
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = scan(/\A(?-mix:[-+]?)/)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = scan(/\A(?-mix:[0-9]+)/)
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    if _tmp
      text = get_text(_text_start)
    end
    set_failed_rule :_real unless _tmp
    return _tmp
  end

  # imag = (real | int) "i"
  def _imag

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_real)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_int)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("i")
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_imag unless _tmp
    return _tmp
  end

  Rules = {}
  Rules[:_root] = rule_info("root", "statements:s end-of-file { s }")
  Rules[:_statements] = rule_info("statements", ".")
  Rules[:_end_hyphen_of_hyphen_file] = rule_info("end-of-file", "!.")
  Rules[:_utfw] = rule_info("utfw", "(/[A-Za-z0-9_$@;`{}]/ | \"\\\\304\" /[\\250-\\277]/ | /[\\305-\\337]/ /[\\200-\\277]/ | /[\\340-\\357]/ /[\\200-\\277]/ /[\\200-\\277]/ | /[\\360-\\364]/ /[\\200-\\277]/ /[\\200-\\277]/ /[\\200-\\277]/)")
  Rules[:_utf8] = rule_info("utf8", "(/[\\t\\n\\r\\40-\\176]/ | /[\\302-\\337]/ /[\\200-\\277]/ | /[\\340-\\357]/ /[\\200-\\277]/ /[\\200-\\277]/ | /[\\360-\\364]/ /[\\200-\\277]/ /[\\200-\\277]/ /[\\200-\\277]/)")
  Rules[:_nil] = rule_info("nil", "\"nil\" !utfw")
  Rules[:_true] = rule_info("true", "\"true\" !utfw")
  Rules[:_false] = rule_info("false", "\"false\" !utfw")
  Rules[:_hexl] = rule_info("hexl", "/[0-9A-Fa-f]/")
  Rules[:_hex] = rule_info("hex", "\"0x\" < hexl+ >")
  Rules[:_digits] = rule_info("digits", "(\"0\" | /[1-9]/ /[0-9]*/)")
  Rules[:_int] = rule_info("int", "< digits >")
  Rules[:_real] = rule_info("real", "< digits \".\" digits (\"e\" /[-+]?/ /[0-9]+/)? >")
  Rules[:_imag] = rule_info("imag", "(real | int) \"i\"")
  # :startdoc:
end
