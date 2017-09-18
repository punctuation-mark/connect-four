require './lib/player'
class ComputerPlayer < Player
  def play(columns)
    column = columns.sample
    puts "Computer played column: #{column}"
    column
  end
end
