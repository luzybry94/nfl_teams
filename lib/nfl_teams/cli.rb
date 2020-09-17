class NflTeams::CLI

    def greeting
        puts "\nWelcome to NFL Teams! Your one stop shop for info on your favorite football team!\n".blue
        sleep 1
        menu
    end

    def menu
        puts "Type 'teams' to see the full list of NFL teams".cyan
        puts "Type 'exit' to quit the app".cyan
        input = gets.strip.downcase
        if input == 'teams'

          NflTeams::Scraper.team_scraper if NflTeams::Team.all.empty? #scrape teams unless they've already been scraped
          list_teams
          select_team
        elsif input == 'exit'
            puts "\nSee ya later!".blue.italic
        else
            puts "\nCome again?\n\n".red
            menu
        end
    end
        

    def list_teams
        puts ""
        NflTeams::Team.all.each.with_index(1) do |team, index|
            puts "#{index}. #{team.name}".green
        end
    end

    def select_team
        puts "\nPlease select a team's number to see more team info:".cyan
        input = gets.strip.to_i
        if input.between?(1,32)
            if input == 29
                puts "\nThis app doesn't support Patriots fans...\n".red
                sleep 2
                puts "KIDDING! LOLOL :) :)".red
            end
            team_selection = NflTeams::Team.all[input-1]
            show_info(team_selection)
            second_menu(team_selection)
        else
            puts "Please check that number again.".red
            select_team
        end
    end

    def show_info(team_selection)
        # if team wasnt selected already ???
        NflTeams::Scraper.team_info(team_selection) unless team_selection.head_coach
        puts "\n#{team_selection.name}".bold.underline.blue
        puts "Head Coach: #{team_selection.head_coach}"
        puts "Record: #{team_selection.record}"
        puts "Division: #{team_selection.place_in_division}"
        puts "About: The #{team_selection.name} play in #{team_selection.stadium}. The team was established in #{team_selection.established} and currently owned by #{team_selection.owners}."
    end

    def second_menu(team_selection)
        puts "\nDo you wanna see the #{team_selection.name} remaining schdeule? (y/n)".cyan
        input = gets.strip.downcase
        until ["y", "n", "yes", "no"].include?(input)
            puts "Please type 'yes' or 'no'".red
            input = gets.strip.downcase
        end
        if input == "y" || input == "yes"
            puts "\nSilly me! Of course you do!".cyan
            sleep 1
            show_games(team_selection)
        elsif input == "n" || input == "no"
            puts "Do you wanna choose another team? (y/n)".cyan
            input = gets.strip.downcase
            until ["y", "n", "yes", "no"].include?(input)
                puts "Please type 'yes' or 'no'".red
                input = gets.strip.downcase
            end
            if input == "y" || input == "yes"
              list_teams
              select_team
            elsif input == "n" || input == "no"
              puts "\nWell then have a nice day!".blue.italic
            end
        end
    end

    def show_games(team_selection)
        puts "\n...one moment please while I scrape".yellow
        sleep 1
        puts ""
        # team_selection.clear_games
        #unless their schedule was already scraped ???
        NflTeams::Scraper.team_schedule(team_selection) if team_selection.games.empty?
        team_selection.games.each do |game|
          puts "#{game.week}".bold.underline.blue
          puts "#{game.away if game.away} #{game.opponent}"
          puts "#{game.date} - #{game.location}\n\n"
        end
        sleep 1
        third_menu
    end

    def third_menu
        puts "Those are some exciting matchups!".cyan
        sleep 1
        puts "\nSo...what do you wanna do now?\n".yellow
        sleep 1
        menu
    end

end