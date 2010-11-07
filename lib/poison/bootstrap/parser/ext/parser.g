#
# parser.g
# Poison grammar
#
# (c) 2010 Brian Ford
#

%{
#include "ruby.h"

#define YYSTYPE VALUE

%}

potion = -- s:statements end-of-file { $$ = rb_funcall(rb_cObject,
rb_intern("p"), rb_str_new2("we got called")); }

statements = true

utfw = [A-Za-z0-9_$@;`{}]
     | '\304' [\250-\277]
     | [\305-\337] [\200-\277]
     | [\340-\357] [\200-\277] [\200-\277]
     | [\360-\364] [\200-\277] [\200-\277] [\200-\277]
utf8 = [\t\n\r\40-\176]
     | [\302-\337] [\200-\277]
     | [\340-\357] [\200-\277] [\200-\277]
     | [\360-\364] [\200-\277] [\200-\277] [\200-\277]

comma = ','

- = (space | comment)*
-- = (space | comment | end-of-line)*
sep = (end-of-line | comma) (space | comment | end-of-line | comma)*
comment	= '#' (!end-of-line utf8)*
space = ' ' | '\f' | '\v' | '\t'
end-of-line = '\r\n' | '\n' | '\r'
end-of-file = !.

true = "true" !utfw

%%

VALUE poison_parse_file(void) {
  return rb_intern("parsed");
}

void Init_parser(void) {
  VALUE rb_mPoison = rb_const_get(rb_cObject, rb_intern("Poison"));
  VALUE rb_cParser = rb_const_get(rb_mPoison, rb_intern("Parser"));

  rb_define_method(rb_cParser, "parse_file",
      RUBY_METHOD_FUNC(poison_parse_file), 0);
}
