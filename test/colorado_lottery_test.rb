require 'minitest/autorun'
require 'minitest/pride'
require './lib/contestant'
require './lib/game'
require './lib/colorado_lottery'

class ColoradoLotteryTest < Minitest::Test

  def setup
    @lottery = ColoradoLottery.new

    @pick_4 = Game.new('Pick 4', 2)
    @mega_millions = Game.new('Mega Millions', 5, true)
    @cash_5 = Game.new('Cash 5', 1)

    @alexander = Contestant.new({
                           first_name: 'Alexander',
                           last_name: 'Aigades',
                           age: 28,
                           state_of_residence: 'CO',
                           spending_money: 10})

    @benjamin = Contestant.new({
                          first_name: 'Benjamin',
                          last_name: 'Franklin',
                          age: 17,
                          state_of_residence: 'PA',
                          spending_money: 100})

    @frederick = Contestant.new({
                           first_name:  'Frederick',
                           last_name: 'Douglas',
                           age: 55,
                           state_of_residence: 'NY',
                           spending_money: 20})

   @winston = Contestant.new({
                        first_name: 'Winston',
                        last_name: 'Churchill',
                        age: 18,
                        state_of_residence: 'CO',
                        spending_money: 5})

  @alexander.add_game_interest('Pick 4')
  @alexander.add_game_interest('Mega Millions')

  @frederick.add_game_interest('Mega Millions')

  @winston.add_game_interest('Cash 5')
  @winston.add_game_interest('Mega Millions')

  @benjamin.add_game_interest('Mega Millions')
  end

  def test_it_exists
    assert_instance_of ColoradoLottery, @lottery
  end

  def test_lottery_has_attributes
    assert_equal Hash.new, @lottery.registered_contestants
    assert_equal [], @lottery.winners
    assert_equal Hash.new, @lottery.current_contestants
  end

  def test_if_contestant_is_interested_and_of_age
    assert_equal true, @lottery.interested_and_18?(@alexander, @pick_4)
    assert_equal false, @lottery.interested_and_18?(@benjamin, @mega_millions)
    assert_equal false, @lottery.interested_and_18?(@alexander, @cash_5)
  end

  def test_if_contestant_can_register
    assert_equal true, @lottery.can_register?(@alexander, @pick_4)
    assert_equal false, @lottery.can_register?(@alexander, @cash_5)
    assert_equal true, @lottery.can_register?(@frederick, @mega_millions)
    assert_equal false, @lottery.can_register?(@frederick, @cash_5)
    assert_equal false, @lottery.can_register?(@benjamin, @mega_millions)
  end

  def test_actually_registering_contestants
    @lottery.register_contestant(@alexander, @pick_4)
    @lottery.register_contestant(@alexander, @mega_millions)

    registered = {
      @pick_4.name => [@alexander],
      @mega_millions.name => [@alexander]
    }
    assert_equal registered, @lottery.registered_contestants

    @lottery.register_contestant(@frederick, @mega_millions)
    @lottery.register_contestant(@winston, @cash_5)
    @lottery.register_contestant(@winston, @mega_millions)

    @grace = Contestant.new({
                         first_name: 'Grace',
                         last_name: 'Hopper',
                         age: 20,
                         state_of_residence: 'CO',
                         spending_money: 20})

    @grace.add_game_interest('Mega Millions')
    @grace.add_game_interest('Cash 5')
    @grace.add_game_interest('Pick 4')

    @lottery.register_contestant(@grace, @mega_millions)
    @lottery.register_contestant(@grace, @cash_5)
    @lottery.register_contestant(@grace, @pick_4)

    assert_equal [@alexander, @grace], @lottery.eligible_contestants(@pick_4)
  end
end
