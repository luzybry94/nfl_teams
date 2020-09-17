class NflTeams::Game
    attr_accessor :team, :week, :opponent, :date, :location, :away
    @@all = []

    def initialize
        # attributes.each {|key, value| self.send(("{key}="), value)}
        @@all << self
    end

    def self.all
        @all
    end


end