require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'

class ExhibitTest < Minitest::Test

  def test_exhibit_exist
    exhibit = Exhibit.new
    assert_instance_of Exhibit, exhibit
  end
end
