require_relative 'lib/queen_attack'

puts "Queen Attack Problem, by Ian Gerstel"

wq_coords = QueenAttack.get_coords('White')
bq_coords = QueenAttack.get_coords('Black')

@qa = QueenAttack.new(wq_coords, bq_coords)

board = @qa.set_up_board
puts board

@can_attack = @qa.attack_row? || @qa.attack_col? || @qa.attack_diag?

if @can_attack
  puts "The queens can capture one another from these positions.\n"
else
  puts "The queens cannot attack one another from these positions.\n"
end
