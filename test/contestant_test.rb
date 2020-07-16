require 'minitest/autorun'
require 'minitest/pride'
require './lib/contestant'
require './lib/game'

class ContestantTest < Minitest::Test

  def setup
    @alexander = Contestant.new(
              {first_name: 'Alexander',
              last_name: 'Aigiades',
              age: 28,
              state_of_residence: 'CO',
              spending_money: 10})

    @pick_4 = Game.new('Pick 4', 2)
    @mega_millions = Game.new('Mega Millions', 5, true)
  end

  def test_it_exists
    assert_instance_of Contestant, @alexander
  end

  def test_contestant_has_all_attributes
    assert_equal "Alexander Aigiades", @alexander.full_name
    assert_equal 28, @alexander.age
    assert_equal 'CO', @alexander.state_of_residence
    assert_equal 10, @alexander.spending_money
  end

  def test_contestant_out_of_state
    assert_equal false, @alexander.out_of_state?
  end

  def test_contestant_game_interests
    assert_equal [], @alexander.game_interests

    @alexander.add_game_interest(@mega_millions.name)
    @alexander.add_game_interest(@pick_4.name)

    assert_equal ["Mega Millions", "Pick 4"], @alexander.game_interests
  end

end
