class NflTeams::CLI

    def greeting
        puts "\nWelcome to NFL Teams! Your one stop shop for info on your favorite football team!\n\n"
        menu
    end

    def menu
        puts "Type 'teams' to see the full list of NFL teams"
        puts "Type 'exit' to quit the app"
        input = gets.strip.downcase
        if input == 'teams'
          NflTeams::Scraper.team_scraper if NflTeams::Team.all.empty? #scrape teams
          list_teams
          select_team
        elsif input == 'exit'
            puts "\nSee ya later!"
        else
            puts "\nCome again?\n\n"
            menu
        end
    end
        

    def list_teams
        puts ""
        NflTeams::Team.all.each.with_index(1) do |team, index|
            puts "#{index}. #{team.name}"
        end
    end

    def select_team
        puts "\nPlease select a team's number to see more team info"
        input = gets.strip.to_i
        if input.between?(1,32)
            if input == 29
                puts "\nThis app doesn't support Patriots fans...\n\n"
                puts "KIDDING! LOLOL :) :)"
                puts "\nHere's your team info:"
            end
            team_selection = NflTeams::Team.all[input-1]
            show_info(team_selection)
            second_menu(team_selection)
        else
            puts "Please check that number again."
            select_team
        end
    end

    def show_info(team_selection)
        # if team wasnt selected already ???
        NflTeams::Scraper.team_info(team_selection) unless team_selection.head_coach
        puts "\n#{team_selection.name}"
        puts "Head Coach: #{team_selection.head_coach}"
        puts "Record: #{team_selection.record}"
        puts "Division: #{team_selection.place_in_division}"
        puts "About: The #{team_selection.name} play in #{team_selection.stadium}. The team was established in #{team_selection.established} and currently owned by #{team_selection.owners}."
    end

    def second_menu(team_selection)
        puts "\nDo you wanna see the #{team_selection.name} remaining schdeule? (y/n)"
        input = gets.strip.downcase
        until ["y", "n", "yes", "no"].include?(input)
            puts "Please type 'yes' or 'no'"
            input = gets.strip.downcase
        end
        if input == "y" || input == "yes"
            show_games(team_selection)
        elsif input == "n" || input == "no"
            puts "Do you wanna choose another team? (y/n)"
            input = gets.strip.downcase
            until ["y", "n", "yes", "no"].include?(input)
                puts "Please type 'yes' or 'no'"
                input = gets.strip.downcase
            end
            if input == "y" || input == "yes"
              list_teams
              select_team
            elsif input == "n" || input == "no"
              puts "\nWell then have a nice day!"
            end
        end
    end

    def show_games(team_selection)
        puts "\n...one moment please while I scrape"
        puts ""
        #unless their schedule was already scraped ???
        NflTeams::Scraper.team_schedule(team_selection) 
        team_selection.games.each do |game|
          puts "#{game.week}"
          puts "#{game.away if game.away} #{game.opponent}"
          puts "#{game.date} - #{game.location}\n\n"
        end
        third_menu
    end

    def third_menu
        puts "\nSo...what do you wanna do now?\n\n"
        menu
    end

end