class NflTeams::Scraper
  
    def self.team_scraper
        doc = Nokogiri::HTML(open("https://www.nfl.com/teams/"))
        teams = doc.css("div.d3-o-media-object__body.nfl-c-custom-promo__body")
        teams.each do |team|
            new_team = NflTeams::Team.new
            new_team.name = team.css("p").text
            new_team.url = team.css("a")[0].attributes["href"].value
        end
    end

    def self.team_info(team_selection)
        doc = Nokogiri::HTML(open("https://www.nfl.com" + team_selection.url)) 
        binding.pry
        



    end
end