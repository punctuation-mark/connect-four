require 'player'
describe 'Player' do
  let(:player) { Player.new('R') }
  let(:valid_columns) {[ 0, 1, 2, 3, 4, 5, 6]}
  let(:get_user_input) { 0 }
  describe '.initialize' do
    it 'sets the passed piece attribute' do
      expect(player.piece).to eq('R')
    end
  end

  describe '.play' do
    context 'when valid columns are sent as a parameter' do
      it 'returns the user input value' do
        expect(player.play(valid_columns)).to eq(0)
      end
    end
  end
end
