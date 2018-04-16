
require_relative 'greed.rb'

puts "How players do you want fork?"
game = Game.new(gets.chomp.to_i)
game.start_game