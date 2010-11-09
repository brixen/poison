#ifndef POISON_PARSER_H
#define POISON_PARSER_H

#ifdef __cplusplus
extern "C" {
#endif

#ifndef O_BINARY
#define O_BINARY 0
#endif

typedef struct PoisonParserState {
  unsigned int pos;
  unsigned int size;
  char*        bytes;
  VALUE        parser;
} Poison;

VALUE poison_parse(VALUE self, VALUE string);

#ifdef __cplusplus
}
#endif

#endif
