require 'computer_player'
require 'player'
describe 'ComputerPlayer' do
  let(:computer_player) { ComputerPlayer.new('Y') }
  let(:valid_columns) {[ 0, 1, 2, 3, 4, 5, 6]}

  describe '.play' do
    context 'when valid columns are sent as a parameter' do
      it 'returns a random column from parameter list' do
        expect(valid_columns.include?(computer_player.play(valid_columns).to_i)).to be_truthy
      end
    end
  end
end
