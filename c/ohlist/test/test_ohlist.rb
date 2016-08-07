gem "minitest"
require "minitest/autorun"
require "ohlist"

class TestOhlist < Minitest::Test
  def test_sanity
    assert_equal true, Ohlist.respond_to?(:foldl)
    assert_equal true, Ohlist.respond_to?(:foldr)
  end

  def test_foldr_block_with_numbers
    numbers = [1, 2, 3]
    result = Ohlist.foldr(numbers, 0) do |el, acc|
      acc + el
    end
    assert_equal 6, result
  end

  def test_foldr_block_with_strings
    names = ['Adam', 'Pahlevi', 'Baihaqi']
    result = Ohlist.foldr(names, '') do |name, acc|
      "#{acc}#{name} "
    end
    assert_equal 'Adam Pahlevi Baihaqi ', result
  end

  def test_foldl_block_with_numbers
    numbers = [4, 6]
    result = Ohlist.foldl(numbers, 48) do |el, acc|
      acc / el
    end
    assert_equal 2, result
  end

  def test_foldl_block_with_strings
    names = ['Adam', 'Pahlevi', 'Baihaqi']
    result = Ohlist.foldl(names, '') do |name, acc|
      "#{acc}#{name} "
    end
    assert_equal 'Baihaqi Pahlevi Adam ', result
  end

  def test_foldr_proc_with_numbers
    numbers = [1, 2, 3]
    summr = -> (el, acc) { acc + el }
    assert_equal 6, Ohlist.foldr(numbers, 0, summr)
  end

  def test_foldr_proc_with_strings
    names = ['Adam', 'Pahlevi', 'Baihaqi']
    concatr = -> (name, acc) { "#{acc}#{name} " }
    assert_equal 'Adam Pahlevi Baihaqi ', Ohlist.foldr(names, '', concatr)
  end

  def test_foldl_proc_with_numbers
    numbers = [4, 6]
    dividr = -> (el, acc) { acc / el }
    assert_equal 2, Ohlist.foldl(numbers, 48, dividr)
  end

  def test_foldl_proc_with_strings
    names = ['Adam', 'Pahlevi', 'Baihaqi']
    concatr = -> (name, acc) { "#{acc}#{name} " }
    assert_equal 'Baihaqi Pahlevi Adam ', Ohlist.foldl(names, '', concatr)
  end
end
