require_relative "nfl_teams/version"

require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative "nfl_teams/cli"
require_relative "nfl_teams/scraper"
require_relative "nfl_teams/team"

module NflTeams
  class Error < StandardError; end
  # Your code goes here...
end
