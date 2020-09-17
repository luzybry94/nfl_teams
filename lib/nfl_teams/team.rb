class NflTeams::Team
    attr_accessor :name, :url, :stadium, :record, :place_in_division, :head_coach, :established, :owners, :homepage, :game1, :game2, :game3

    @@all = []

    def initialize(name, url)
      @name = name
      @url = url
      @@all << self
    end

    def self.all
        @@all
    end

    def find_schedule
        NflTeams::Schedule.all.find {|schedule| schedule.team == self}
    end

end