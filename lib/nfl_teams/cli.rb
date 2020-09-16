class NflTeams::CLI

    def greeting
        puts "Welcome to NFL Teams! Your one stop shop for info on your favorite football team!"
        menu
    end

    def menu
        puts "Type 'teams' to see the full list of NFL teams"
        puts "Type 'exit' to quit the app"
        input = gets.strip.downcase
        if input == 'teams'
          NflTeams::Scraper.team_scraper #scrape teams
          list_teams
          select_team
        elsif input == 'exit'
            puts "See ya later!"
        else
            puts "Come again?"
            menu
        end
    end
        

    def list_teams
        NflTeams::Team.all.each.with_index(1) do |team, index|
            puts "#{index}. #{team.name}"
        end
    end

    def select_team
        puts "Please select a team's number to see more team info"
        input = gets.strip.to_i
        if input.between?(1,32)
            team_selection = NflTeams::Team.all[input-1]
            show_info(team_selection)
            second_menu
        else
            puts "Please check that number again."
            select_team
        end
    end

    def show_info(team_selection)
        NflTeams::Scraper.team_info(team_selection)
        
    end

end