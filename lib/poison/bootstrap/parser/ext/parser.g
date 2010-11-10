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

#define PN_AST(n, v)  rb_funcall(P->parser, rb_intern(n), 1, v)

%}

poison = -- s:statements end-of-file { $$ = rb_funcall(P->parser,
rb_intern("result"), 1, s); }

statements = s1:stmt {  }
        (sep s2:stmt {  })*
         sep?
     | ''            { $$ = Qnil; }

stmt = s:sets
       ( or x:sets          {  }
       | and x:sets         {  })*
       {  }

sets = e:eqs
       ( assign s:sets       {  }
       | or assign s:sets    {  }
       | and assign s:sets   {  }
       | pipe assign s:sets  {  }
       | caret assign s:sets {  }
       | amp assign s:sets   {  }
       | bitl assign s:sets  {  }
       | bitr assign s:sets  {  }
       | plus assign s:sets  {  }
       | minus assign s:sets {  }
       | times assign s:sets {  }
       | div assign s:sets   {  }
       | rem assign s:sets   {  }
       | pow assign s:sets   {  })?
       {  }

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
     | e:expr         {  }

expr = ( mminus a:atom {  }
       | pplus a:atom   {  }
       | a:atom (pplus  {  }
               | mminus {  })?) {  }
         (c:call {  })*
       {  }

atom = e:value | e:closure | e:table | e:call

call = (n:name {  } (v:value | v:table)? |
       (v:value | v:table) {  })
         b:block? {  }

name = p:path           {  }
     | quiz ( m:message {  }
            | p:path    {  })
     | !keyword
       m:message        {  }

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
      | v:unquoted {  }

closure = t:table? b:block {  }
table = table-start s:statements table-end {  }
block = block-start s:statements block-end {  }
lick = lick-start i:lick-items lick-end {  }

path = '/' message      {  }
message = < utfw+ > -   {  }

value = i:immed - {  }
      | lick

immed = nil    { $$ = Qnil; }
      | true   { $$ = Qtrue; }
      | false  { $$ = Qfalse; }
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
pplus = "++" -
mminus = "--" -
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
real = < digits '.' digits ('e' [-+] [0-9]+)? >
imag = real 'i'

q1 = [']
c1 = < (!q1 utf8)+ > {  }
str1 = q1 {  }
       < (q1 q1 {  } | c1)* >
       q1 {  }

esc         = '\\'
escn        = esc 'n' {  }
escb        = esc 'b' {  }
escf        = esc 'f' {  }
escr        = esc 'r' {  }
esct        = esc 't' {  }
escu        = esc 'u' < hexl hexl hexl hexl > { }
escc = esc < utf8 > {  }

q2 = ["]
e2 = '\\' ["] {  }
c2 = < (!q2 !esc utf8)+ > {  }
str2 = q2 {  }
       < (e2 | escn | escb | escf | escr | esct | escu | escc | c2)* >
       q2 {  }

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
