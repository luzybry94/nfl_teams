class NflTeams::Schedule
    attr_accessor :team, :week, :opponent, :date, :location
    @@all = []

    def initialize
        # attributes.each {|key, value| self.send(("{key}="), value)}
        @@all << self
    end

    def self.all
        @all
    end


end