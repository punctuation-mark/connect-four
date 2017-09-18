require 'game'
require 'player'
require 'computer_player'
describe 'Game' do
  let(:player1) { Player.new('A') }
  let(:player2) { ComputerPlayer.new('B') }
  let(:subject) { Game.new(player1, player2) }


  describe '.initialize' do
    let(:empty_board) { Array.new(6) { Array.new(7, 'O') } }

    it 'sets an empty board attribute' do
      expect(subject.board.matrix).to eq(empty_board)
    end

    it 'sets player1 attribute' do
      expect(subject.player1).to eq(player1)
    end

    it 'sets player2 attribute' do
      expect(subject.player2).to eq(player2)
    end
  end

  describe '.current_player' do
    it 'returns the current player' do
      expect(subject.current_player).to eq(player1)
    end
  end

  describe '.play' do

    context 'when game ends and there is no winner' do
      specify do
        allow(subject).to receive(:game_over?).and_return(true)

        expect { subject.play }.to output('Game drawn').to_stdout
      end
    end

    context 'when game ends and there is a winner' do
      specify do
        allow(subject).to receive(:game_over?).and_return(true)
        subject.winner = 'R'
        expect { subject.play }.to output('Congrats! R has won the game').to_stdout
      end
    end
  end
end
