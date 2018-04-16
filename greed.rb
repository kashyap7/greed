
require_relative 'player.rb'
require_relative 'diceset.rb'
class Game
  TARGET = 3000
  DICE_COUNT = 5
  def initialize(player_count)
    @player_count = player_count
    @players = {}
    @dice = DiceSet.new
    player_count.times do |idx|
      @players[idx + 1] = Player.new
    end
  end

  def display_scores
    puts "Score Card"
    puts "-----------"
    @players.each do |id,player|
      puts "Player #{id} : #{player.total_points}"
    end
  end

  def target_breached?
    @players.each do |id, player|
      if player.total_points >= TARGET
        puts "TARGET BREACHED"
        return true
      end
    end
    return false
  end

#need to break the current function to smaller chunks
  def execute_turn
    display_scores

    @players.each do |idx, player|
      dice_count = DICE_COUNT
      current_score = 0

      loop do
        @dice.roll(dice_count)
        dice_score = @dice.score
        current_score = (dice_score == 0)? 0: current_score + dice_score

        @dice.dump_values("Player #{idx} rolls ")
        puts "Score in this round: #{current_score}"
        puts "Total score: #{player.total_points}"

        non_scoring_dice = @dice.non_scoring_dice_count
        dice_count = (non_scoring_dice == 0)? DICE_COUNT: non_scoring_dice
        # Have modified the print to show the dice he can re-roll
        if current_score != 0
          puts "You can roll #{dice_count} dice again, do you want to(y/n)?"
          re_roll = gets.chomp
        end
        break if (current_score == 0) || re_roll == "n"
      end

      next if current_score == 0
      player.add_points(current_score)
    end
  end

  def end_game
    display_scores
    winner_id, winner = @players.max_by {|k,v| v.total_points}
    puts "Player #{winner_id} wins the game with #{winner.total_points} points"
    puts "And the game ends!"
  end

  def start_game
    round = 0
    until target_breached?
      round += 1
      puts "Turn #{round}"
      puts "--------------"
      execute_turn
    end
    puts "LAST TURN"
    puts "----------------"
    # We run final round when the target is breached
    execute_turn
    end_game
  end

end