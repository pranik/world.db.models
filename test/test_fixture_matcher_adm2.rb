# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_fixture_matcher_adm2.rb


require 'helper'


class TestFixtureMatcherAdm2 < MiniTest::Test

  include WorldDb::Matcher

  def test_de
    de = [
       'de-deutschland!/by-bayern/districts',
       'de-deutschland/by-bayern/districts',
       'de-deutschland!/3--by-bayern/districts',
       'de-deutschland/3--by-bayern/districts',
       'europe/de-deutschland!/3--by-bayern/districts',
       'europe/de-deutschland/3--by-bayern/districts',
    ]
    assert_match_adm2_for_country( de, 'de', 'by' )
  end # method test_de

  def test_at
    at = [
       'at-austria!/n-niederoesterreich/counties',
       'at-austria/n-niederoesterreich/counties',
       'at-austria!/1--n-niederoesterreich/counties',
       'at-austria/1--n-niederoesterreich/counties',
       'at-austria!/1--n-niederoesterreich/counties',
       'europe/at-austria/1--n-niederoesterreich/counties',
    ]
    assert_match_adm2_for_country( at, 'at', 'n' )
  end # method test_at


  def test_at_more
    b = [ 'at-austria!/1--b-burgenland/counties' ]
    n = [ 'at-austria!/2--n-niederoesterreich/counties' ]
    w = [ 'at-austria!/3--w-wien/counties' ]

    assert_match_adm2_for_country( b, 'at', 'b' )
    assert_match_adm2_for_country( n, 'at', 'n' )
    assert_match_adm2_for_country( w, 'at', 'w' )
  end


private
  def assert_match_adm2_for_country( ary, expected_country_key, expected_region_key )
    ary.each do |name|
      found = match_adm2_for_country( name ) do |country_key,region_key|
        assert_equal country_key, expected_country_key,  "#{expected_country_key} expected is #{country_key}"
        assert_equal region_key,  expected_region_key,   "#{expected_region_key} expected is #{region_key}"
      end
      assert found, "no match for '#{name}'"
    end
  end

end # class TestFixtureMatcherAdm2
