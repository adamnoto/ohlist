gem "minitest"
require "minitest/autorun"
require "ohlist"

class TestOhlist < Minitest::Test
  def test_sanity
    assert_equal true, Ohlist.respond_to?(:foldl)
    assert_equal true, Ohlist.respond_to?(:foldr)
  end
end
