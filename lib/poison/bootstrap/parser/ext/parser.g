#
# parser.g
# Poison grammar
#
# (c) 2010 Brian Ford
#

%{

#include "ruby.h"
#include "parser.h"

#define YY_INPUT(buf, result, max) {  \
  if (P->pos < P->size) {             \
    result = max;                     \
    if(P->pos + max > P->size)        \
      result = P->size - P->pos;      \
    memcpy(buf, P->bytes, result+1);  \
    P->pos += max;                    \
  } else {                            \
    result = 0;                       \
  }                                   \
}

#define YYSTYPE VALUE
#define YY_XTYPE Poison*
#define YY_XVAR P
#define YY_NAME(N) poison_code_##N

%}

poison = -- s:statements end-of-file { rb_funcall(P->parser, rb_intern("success!"), 0); }

statements = true --

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

VALUE poison_parse(VALUE self, VALUE string) {
  Poison P;

  P.parser = self;
  P.pos = 0;
  P.size = RSTRING_LEN(string);
  P.bytes = RSTRING_PTR(string);

  VALUE result = Qtrue;
  GREG *G = poison_code_parse_new(&P);
  G->pos = G->limit = 0;

  if (!poison_code_parse(G)) result = Qfalse;
  poison_code_parse_free(G);

  return result;
}

void Init_parser(void) {
  VALUE rb_mPoison = rb_const_get(rb_cObject, rb_intern("Poison"));
  VALUE rb_cParser = rb_const_get(rb_mPoison, rb_intern("Parser"));

  rb_define_method(rb_cParser, "parse", RUBY_METHOD_FUNC(poison_parse), 1);
}
