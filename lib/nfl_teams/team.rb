class NflTeams::Team
    attr_accessor :name, :url, :stadium, :record, :place_in_division, :head_coach, :established, :owners, :homepage, :game1, :game2, :game3
    attr_reader :games
    @@all = []

    def initialize(name, url)
      @name = name
      @url = url
      @games = []
      @@all << self
    end

    def self.all
        @@all
    end

    def add_game(game)
      @games << game
      game.team = self
    end

    def clear_games
        @games.clear
    end

end