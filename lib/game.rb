require './lib/player'
require './lib/computer_player'
require './lib/board'
class Game
  extend Forwardable
  attr_accessor :winner
  attr_reader :board, :player1, :player2
  delegate display: :board, valid_columns: :board

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @winner = nil
  end

  def current_player
    @current_player ||= @player1
  end

  def self.start
    player1 = Player.new('R')
    player2 = ComputerPlayer.new('Y')
    game = Game.new(player1, player2)
    game.display
    game.play
  end

  def play
    @current_player = @player1
    until game_over?
      player_turn = @current_player.play(valid_columns)
      redo unless @board.move(player_turn, @current_player.piece)
      @current_player = @current_player == @player1 ? @player2 : @player1
      display
    end
    if @winner.nil?
      puts 'Game drawn'
    else
      puts "Congrats! #{@winner} has won the game"
    end
    exit(0)
  end

  private

  def game_over?
    @winner = @board.winner
    @board.valid_columns.empty? || !@winner.nil?
  end
end
