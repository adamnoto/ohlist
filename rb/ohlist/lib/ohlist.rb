require "ohlist/version"

module Ohlist
  extend self

  # func contains accumulator
  def foldr(list, accumulator, func = nil)
    acc = accumulator
    list.each do |element|
      if block_given?
        acc = yield element, acc
      else
        acc = func.(element, acc)
      end
    end
    acc
  end

  def foldl(list, accumulator, func = nil, &block)
    if block_given?
      foldr(list.reverse, accumulator, &block)
    else
      foldr(list.reverse, accumulator, func)
    end
  end
end
