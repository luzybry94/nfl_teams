class NflTeams::Scraper
  
    def self.team_scraper
        doc = Nokogiri::HTML(open("https://www.nfl.com/teams/"))
        teams = doc.css("div.d3-o-media-object__body.nfl-c-custom-promo__body")
        teams.each do |team| 
            name = team.css("p").text
            url = team.css("a")[0].attributes["href"].value
            NflTeams::Team.new(name, url)
        end
    end

    def self.team_info(team_selection)
        doc = Nokogiri::HTML(open("https://www.nfl.com" + team_selection.url)) 
          team_selection.record = doc.css("div.nfl-c-team-header__stats.nfl-u-hide-empty").text
          team_selection.place_in_division = doc.css("div.nfl-c-team-header__ranking.nfl-u-hide-empty").text
          team_selection.head_coach = doc.css("div.nfl-c-team-info__info-value")[0].text
          team_selection.owners = doc.css("div.nfl-c-team-info__info-value")[2].text
          team_selection.stadium = doc.css("div.nfl-c-team-info__info-value")[1].text
          team_selection.established = doc.css("div.nfl-c-team-info__info-value")[3].text
          team_selection.homepage = doc.css("li.d3-o-list__item a")[0].attributes["href"].value
    end

    def self.team_schedule(team_selection)
        doc = Nokogiri::HTML(open(team_selection.homepage + "schedule/"))
        games = doc.css("div.nfl-o-matchup-cards.nfl-o-matchup-cards--pre-game")
        games.each do |game|
            # attributes = {
            # team: team_selection,
            # week: game.css("p.nfl-o-matchup-cards__date-info strong").text,
            # date: game.css("p.nfl-o-matchup-cards__date-info span").text,
            # opponent: game.css("p.nfl-o-matchup-cards__team-full-name").text.strip,
            # location: game.css("span.nfl-o-matchup-cards__venue--location").text.strip 
            # }
            # NflTeams::Schedule.new(attributes)
            new_game = NflTeams::Game.new
            new_game.week = game.css("p.nfl-o-matchup-cards__date-info strong").text
            new_game.date = game.css("p.nfl-o-matchup-cards__date-info span").text
            new_game.opponent = game.css("p.nfl-o-matchup-cards__team-full-name").text.strip
            new_game.location = game.css("span.nfl-o-matchup-cards__venue--location").text.strip 
            new_game.away = game.css("p.nfl-o-matchup-cards__team-game-location span").text
            team_selection.add_game(new_game)
            # binding.pry
        end
     end
end