class ColoradoLottery
  attr_reader :winners,
              :current_contestants

  attr_accessor :registered_contestants

  def initialize
    @registered_contestants = Hash.new(0)
    @winners = []
    @current_contestants = {}
  end

  def interested_and_18?(contestant, game)
    if contestant.age >= 18 && contestant.game_interests.include?(game.name)
      true
    else
      false
    end
  end

  def can_register?(contestant, game)
    var = interested_and_18?(contestant, game)
    residence = contestant.state_of_residence
    national_game = game.national_drawing?

    if var == true && (residence == "CO" || national_game == true)
      true
    else
      false
    end
  end

  def register_contestant(contestant, game)
    if @registered_contestants.keys.include?(game.name)
      @registered_contestants[game.name] << contestant
    else
      @registered_contestants[game.name] = [contestant]
    end
  end

  def eligible_contestants(game)
    @registered_contestants[game.name]
  end
end
