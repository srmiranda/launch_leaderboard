require 'pry'
def game_info
   [
    {
      home_team: "Patriots",
      away_team: "Broncos",
      home_score: 7,
      away_score: 3
    },
    {
      home_team: "Broncos",
      away_team: "Colts",
      home_score: 3,
      away_score: 0
    },
    {
      home_team: "Patriots",
      away_team: "Colts",
      home_score: 11,
      away_score: 7
    },
    {
      home_team: "Steelers",
      away_team: "Patriots",
      home_score: 7,
      away_score: 21
    }
  ]
end

class Team
  attr_accessor :name, :rank, :wins, :losses
  def initialize(name, rank=0, wins=0, losses=0)
    @name   = name
    @rank   = rank
    @wins   = wins
    @losses = losses
  end

  def add_wins
    @wins += 1
  end

  def add_losses
    @losses += 1
  end

  def add_rank
    @rank += 1
  end

  def summary
    summary = "| "
    summary += "#{@name}".ljust(10)
    summary += "#{@rank}".ljust(10)
    summary += "#{@wins}".ljust(14)
    summary += "#{@losses}".ljust(13)
    summary += "|"
  end
end

teams = {}

game_info.each do |info|
  home_team = info[:home_team]
  away_team = info[:away_team]

  if !teams.has_key?(home_team)
    home_team = Team.new(home_team)
    teams[home_team.name] = home_team
  elsif !teams.has_key?(away_team)
    away_team = Team.new(away_team)
    teams[away_team.name] = away_team
  end
end

game_info.each do |info|
 if info[:home_score] > info[:away_score]
   teams[info[:home_team]].add_wins
   teams[info[:away_team]].add_losses
 else
   teams[info[:home_team]].add_losses
   teams[info[:away_team]].add_wins
 end
end

rank_teams = teams.sort_by {|team, info| info.losses}

rank = 1
rank_teams.each do |team, info|
  info.rank += rank
  rank += 1
end

puts "--------------------------------------------------"
header = "| Name      Rank      Total Wins    Total Losses |"
puts header
rank_teams.each {|team, info| puts "#{info.summary}"}
puts "--------------------------------------------------"
