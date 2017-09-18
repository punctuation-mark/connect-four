class Player
  attr_reader :piece

  def initialize(value)
    @piece = value
  end

  def play(columns)
    puts "Valid columns are: #{columns.join(', ')}"
    get_user_input
  end

  private
  def get_user_input
    gets.chomp.to_i
  end
end
