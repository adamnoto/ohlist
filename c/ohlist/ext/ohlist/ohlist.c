#include <ruby.h>

static VALUE foldl(VALUE list, VALUE accumulator, VALUE func) {
  return 0;
}

static VALUE foldr(VALUE list, VALUE accumulator, VALUE func) {
  return 0;
}

void Init_ohlist() {
  VALUE mOhlist = rb_define_module("Ohlist");
  rb_define_singleton_method(mOhlist, "foldl", foldl, 4);
  rb_define_singleton_method(mOhlist, "foldr", foldr, 4);
}
