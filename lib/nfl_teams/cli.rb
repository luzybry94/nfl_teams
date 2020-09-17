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
            second_menu(team_selection)
        else
            puts "Please check that number again."
            select_team
        end
    end

    def show_info(team_selection)
        NflTeams::Scraper.team_info(team_selection)
        puts "Here's some info on the #{team_selection.name}:"
        puts "Head Coach: #{team_selection.head_coach}"
        puts "Record: #{team_selection.record}"
        puts "Division: #{team_selection.place_in_division}"
        puts "About: The #{team_selection.name} play in #{team_selection.stadium}. The team was established in #{team_selection.established} and is currently owned by #{team_selection.owners}."
    end

    def second_menu(team_selection)
        # puts "Do you wanna see the #{team_selection.name} remaining schdeule? (y/n)"
        # input = gets.strip.downcase
        # until input == "n" || input == "y"
        #     puts "Please type 'y' or 'n'"
        #     input = gets.strip.downcase
        # end
        # if input == "y"
        #     show_schedule(team_selection)
        # elsif input == "n"
            puts "Do you wanna choose another team? (y/n)"
            input = gets.strip.downcase
            until input == "n" || input == "y"
                puts "Please type 'y' or 'n'"
                input = gets.strip.downcase
            end
            if input == "y"
              list_teams
              select_team
            elsif input == "n"
              puts "Well then have a nice day!"
            end
        # end
    end

    # def show_schedule(team_selection)
    #     NflTeams::Scraper.team_schedule(team_selection)
    #     binding.pry

    # end

end