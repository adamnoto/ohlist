#include <ruby.h>

static VALUE
fold(int argNum, VALUE list, VALUE accumulator, VALUE lambda) {
  int listLen = RARRAY_LEN(list);
  int i;

  if (argNum == 2) {
    // must declare a block, as no proc is given!
    if (!rb_block_given_p()) {
      rb_need_block();
    } else {
      for(i = 0; i<listLen; i++) {
        accumulator = rb_yield_values(2, rb_ary_entry(list, i), accumulator);
      }
    }
  }

  return accumulator;
}

static VALUE
foldr(int argc, VALUE *argv, VALUE obj) {
  // the initial value, as well as the accumulator
  VALUE accumulator;
  // the list (array)
  VALUE list;
  // the proc/lambda
  VALUE lambda;

  int argNum = rb_scan_args(argc, argv, "21", &list, &accumulator, &lambda);

  VALUE result = fold(argNum, list, accumulator, lambda);

  return result;
}

static VALUE
foldl(int argc, VALUE *argv, VALUE obj) {
  VALUE accumulator, list, lambda;
  int argNum = rb_scan_args(argc, argv, "21", &list, &accumulator, &lambda);
  list = rb_ary_reverse(list);
  VALUE result = fold(argNum, list, accumulator, lambda);
  return result;
}

void Init_ohlist() {
  VALUE mOhlist = rb_define_module("Ohlist");
  rb_define_singleton_method(mOhlist, "foldr", foldr, -1);
  rb_define_singleton_method(mOhlist, "foldl", foldl, -1);
}
