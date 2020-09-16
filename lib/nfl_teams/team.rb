class NflTeams::Team
    attr_accessor :name, :url, :last_game, :next_game, :record, :place_in_division, :head_coach

    @@all = []

    def initialize()
      @@all << self
    end

    def self.all
        @@all
    end

end