#include <stdio.h>void a2(int *a, int b, int c) { printf("%d", (int)(&c - &b)); }void a1(int a) { a2(&a,a+4,a+2); }int main() { a1(9); return 0; }
