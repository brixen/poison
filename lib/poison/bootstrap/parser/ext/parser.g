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

#define PN_VAL(n)         rb_funcall(P->parser, rb_intern(n), 0)
#define PN_AST(n, v)      rb_funcall(P->parser, rb_intern(n), 1, v)
#define PN_AST2(n, x, y)  rb_funcall(P->parser, rb_intern(n), 2, x, y)
#define PN_OP(n, l, r)    rb_funcall(P->parser, rb_intern(n), 2, l, r)

%}

poison = -- s:statements end-of-file { $$ = P->ast = PN_AST("statements", s); }

statements = s1:stmt { $$ = PN_AST("statement_start", s1); }
        (sep s2:stmt { $$ = PN_AST("statement_add", s2); })*
         sep?
     | ''            { $$ = PN_VAL("nil_kind"); }

stmt = s:sets
       ( or x:sets          {  }
       | and x:sets         {  })*
       {  }

sets = e:eqs
       ( assign s:sets       { e = PN_OP("assign", e, s); }
       | or assign s:sets    { e = PN_OP("assign", e, PN_OP("op_or", e, s)); }
       | and assign s:sets   { e = PN_OP("assign", e, PN_OP("op_and", e, s)); }
       | pipe assign s:sets  { e = PN_OP("assign", e, PN_OP("pipe", e, s)); }
       | caret assign s:sets { e = PN_OP("assign", e, PN_OP("caret", e, s)); }
       | amp assign s:sets   { e = PN_OP("assign", e, PN_OP("amp", e, s)); }
       | bitl assign s:sets  { e = PN_OP("assign", e, PN_OP("bitl", e, s)); }
       | bitr assign s:sets  { e = PN_OP("assign", e, PN_OP("bitr", e, s)); }
       | plus assign s:sets  { e = PN_OP("assign", e, PN_OP("plus", e, s)); }
       | minus assign s:sets { e = PN_OP("assign", e, PN_OP("minus", e, s)); }
       | times assign s:sets { e = PN_OP("assign", e, PN_OP("times", e, s)); }
       | div assign s:sets   { e = PN_OP("assign", e, PN_OP("div", e, s)); }
       | rem assign s:sets   { e = PN_OP("assign", e, PN_OP("rem", e, s)); }
       | pow assign s:sets   { e = PN_OP("assign", e, PN_OP("pow", e, s)); })?
       { $$ = e; }

eqs = c:cmps
      ( cmp x:cmps          {  }
      | eq x:cmps           {  }
      | neq x:cmps          {  })*
      {  }

cmps = o:bitors
       ( gte x:bitors        {  }
       | gt x:bitors         {  }
       | lte x:bitors        {  }
       | lt x:bitors         {  })*
       {  }

bitors = a:bitand
         ( pipe x:bitand       {  }
         | caret x:bitand      {  })*
         {  }

bitand = b:bitshift
         ( amp x:bitshift      {  })*
         {  }

bitshift = s:sum
           ( bitl x:sum          {  }
           | bitr x:sum          {  })*
           {  }

sum = p:product
      ( plus x:product      {  }
      | minus x:product     {  })*
      {  }

product = s:sign
          ( times x:sign           {  }
          | div x:sign             {  }
          | rem x:sign             {  }
          | pow x:sign             {  })*
          {  }

sign = minus !minus s:sign   {  }
     | plus !plus s:sign     {  }
     | not s:sign     {  }
     | wavy s:sign    {  }
     | e:expr         { $$ = e; }

expr = ( a:atom ) { a = PN_AST("call_list", a); }
         (c:call { a = PN_AST2("call_append", a, c); })*
       { $$ = PN_AST("expr", a); }

atom = e:value | e:closure | e:table | e:call

call = (n:name { v = Qnil; b = Qnil; } (v:value | v:table)? |
       (v:value | v:table) { n = PN_AST("message", Qnil); b = Qnil; })
         b:block? { $$ = n;   }

name = p:path           { $$ = PN_AST("path", p); }
     | quiz ( m:message { $$ = PN_AST("query", m); }
            | p:path    { $$ = PN_AST("pathq", p); })
     | !keyword
       m:message        { $$ = PN_AST("message", m); }

lick-items = i1:lick-item     {  }
            (sep i2:lick-item {  })*
             sep?
           | ''               {  }

lick-item = m:message t:table v:loose {  }
          | m:message t:table {  }
          | m:message v:loose t:table {  }
          | m:message v:loose {  }
          | m:message         {  }

loose = value
      | v:unquoted { $$ = PN_AST("value", v); }

closure = t:table? b:block {  }
table = table-start s:statements table-end { $$ = PN_AST("table", s); }
block = block-start s:statements block-end {  }
lick = lick-start i:lick-items lick-end {  }

path = '/' m:message    { $$ = PN_AST("path", m); }
message = < utfw+ > -   { $$ = rb_str_new(yytext, yyleng); }

value = i:immed - { $$ = PN_AST("value", i); }
      | lick

immed = nil    { $$ = PN_VAL("nil_kind"); }
      | true   { $$ = PN_VAL("true_kind"); }
      | false  { $$ = PN_VAL("false_kind"); }
      | imag   { $$ = PN_AST("imag", rb_str_new(yytext, yyleng)); }
      | real   { $$ = PN_AST("real", rb_str_new(yytext, yyleng)); }
      | hex    { $$ = PN_AST("hex", rb_str_new(yytext, yyleng)); }
      | int    { $$ = PN_AST("int", rb_str_new(yytext, yyleng)); }
      | str1 | str2

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
block-start = ':' --
block-end = '.' -
table-start = '(' --
table-end = ')' -
lick-start = '[' --
lick-end = ']' -
quiz = '?' --
assign = '=' --
minus = '-' --
plus = '+' --
wavy = '~' --
times = '*' --
div = '/' --
rem = '%' --
pow = "**" --
bitl = "<<" --
bitr = ">>" --
amp = '&' --
caret = '^' --
pipe = '|' --
lt = '<' --
lte = "<=" --
gt = '>' --
gte = ">=" --
neq = "!=" --
eq = "==" --
cmp = "<=>" --
and = ("&&" | "and" !utfw) --
or = ("||" | "or" !utfw) --
not = ("!" | "not" !utfw) --
keyword = "and" | "or" | "not"

nil = "nil" !utfw
true = "true" !utfw
false = "false" !utfw
hexl = [0-9A-Fa-f]
hex = '0x' < hexl+ >
digits = '0' | [1-9] [0-9]*
int = < digits >
real = < digits '.' digits ('e' [-+]? [0-9]+)? >
imag = (real | int) 'i'

q1 = [']
c1 = < (!q1 utf8)+ > { PN_AST("str1_add", rb_str_new(yytext, yyleng)); }
str1 = q1 { PN_AST("str1_clear", Qnil); }
       < (q1 q1 { PN_AST("str1_add", rb_str_new2("'")); } | c1)* >
       q1 { $$ = PN_AST("str1", Qnil); }

esc         = '\\'
escn        = esc 'n' {  }
escb        = esc 'b' {  }
escf        = esc 'f' {  }
escr        = esc 'r' {  }
esct        = esc 't' {  }
escu        = esc 'u' < hexl hexl hexl hexl > { }
escc = esc < utf8 > {  }

q2 = ["]
e2 = '\\' ["] { PN_AST("str2_add", rb_str_new2("\"")); }
c2 = < (!q2 !esc utf8)+ > { PN_AST("str2_add", rb_str_new(yytext, yyleng)); }
str2 = q2 { PN_AST("str2_clear", Qnil); }
       < (e2 | escn | escb | escf | escr | esct | escu | escc | c2)* >
       q2 { $$ = PN_AST("str2", Qnil); }

unq-char = '{' unq-char+ '}'
         | '[' unq-char+ ']'
         | '(' unq-char+ ')'
         | !'{' !'[' !'(' !'}' !']' !')' utf8
unq-sep = sep !'{' !'[' !'('
unquoted = < (!unq-sep !lick-end unq-char)+ > {  }

- = (space | comment)*
-- = (space | comment | end-of-line)*
sep = (end-of-line | comma) (space | comment | end-of-line | comma)*
comment	= '#' (!end-of-line utf8)*
space = ' ' | '\f' | '\v' | '\t'
end-of-line = '\r\n' | '\n' | '\r'
end-of-file = !.

$ sig = args+ end-of-file
args = arg-list (arg-sep arg-list)*
arg-list = arg-set (optional arg-set)?
         | optional arg-set
arg-set = arg (comma - arg)*

arg-name = < utfw+ > - {  }
arg-type = < ('s' | 'S' | 'n' | 'N' | 'b' | 'B' | 'k' | 't' | 'o' | 'O' | '-' | '&') > -
       {  }
arg = n:arg-name assign t:arg-type
                       {  }
    | t:arg-type       {  }
optional = '|' -       {  }
arg-sep = '.' -        {  }

%%

VALUE poison_parse_string(VALUE self, VALUE string) {
  Poison P;

  P.parser = self;
  P.pos = 0;
  P.size = RSTRING_LEN(string);
  P.bytes = RSTRING_PTR(string);

  GREG *G = poison_code_parse_new(&P);
  G->pos = G->limit = 0;

  if (!poison_code_parse(G)) {
    rb_funcall(P.parser, rb_intern("syntax_error"), 1, INT2FIX(G->end));
    return P.ast = Qfalse;
  }
  poison_code_parse_free(G);

  return P.ast;
}

void Init_parser(void) {
  VALUE rb_mPoison = rb_const_get(rb_cObject, rb_intern("Poison"));
  VALUE rb_cParser = rb_const_get(rb_mPoison, rb_intern("Parser"));

  rb_define_method(rb_cParser, "parse_string", RUBY_METHOD_FUNC(poison_parse_string), 1);
}
