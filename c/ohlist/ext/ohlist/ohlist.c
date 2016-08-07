#include <ruby.h>

static VALUE
fold(int argNum, VALUE list, VALUE accumulator, VALUE lambda) {
  int listLen = RARRAY_LEN(list);

  // hold value of each iteration of element in the list
  VALUE element = Qundef;
  for(int i=0; i<listLen; i++) {
    // get the element
    element = rb_ary_entry(list, i);

    if (argNum == 2) {
      // raise block not given error if no block passed when
      // given 2 arguments/parameters
      if (!rb_block_given_p()) rb_need_block();
      else
        accumulator = rb_yield_values(2, element, accumulator);
    } else if (argNum == 3) {
      if (rb_class_of(lambda) != rb_cProc)
        rb_raise(rb_eTypeError, "Expected Proc callback");

      accumulator = rb_funcall(lambda, rb_intern("call"), 2,
          element, accumulator);
    } else {
      rb_raise(rb_eArgError, "Unexpected number of arguments. Accepts 2..3");
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
