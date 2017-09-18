require 'board'
describe 'Board' do
  let(:subject) { Board.new }


  describe '.initialize' do
    let(:empty_board) { Array.new(6) { Array.new(7, 'O') } }

    it 'creates an empty board' do
      expect(subject.matrix).to eq(empty_board)
    end
  end

  describe '.add_piece_to_column' do
    let(:board_r0) { [["O", "O", "O", "O", "O", "O", "O"],
                      ["O", "O", "O", "O", "O", "O", "O"],
                      ["O", "O", "O", "O", "O", "O", "O"],
                      ["O", "O", "O", "O", "O", "O", "O"],
                      ["O", "O", "O", "O", "O", "O", "O"],
                      ["R", "O", "O", "O", "O", "O", "O"]] }

    context 'when column is available' do

      it "correctly adds the piece to the board's matrix" do
        allow(subject).to receive(:horizontal_highest_piece).and_return(6)
        subject.add_piece_to_column(0, 'R')
        expect(subject.matrix).to eq(board_r0)
      end

      it 'returns the added piece' do
        allow(subject).to receive(:horizontal_highest_piece).and_return(6)
        expect(subject.add_piece_to_column(0, 'R')).to eq('R')
      end
    end

    context 'when column is full' do

      it "does not add the piece to the board's matrix" do
        allow(subject).to receive(:horizontal_highest_piece).and_return(0)
        expect{ subject.add_piece_to_column(0, 'R') }.to_not change{ subject.matrix }
      end

      it 'returns nil' do
        allow(subject).to receive(:horizontal_highest_piece).and_return(0)
        expect(subject.add_piece_to_column(0, 'R')).to be_nil
      end
    end
  end

  describe '.horizontal_highest_piece' do

    context 'when column has available rows' do

      it 'returns the value of the next highest available row' do
        subject.add_piece_to_column(0, 'R')
        expect(subject.horizontal_highest_piece(0)).to eq(5)
      end
    end

    context 'when column has no available rows' do

      it 'returns 0' do
        subject.add_piece_to_column(0, 'R')
        subject.add_piece_to_column(0, 'R')
        subject.add_piece_to_column(0, 'R')
        subject.add_piece_to_column(0, 'R')
        subject.add_piece_to_column(0, 'R')
        subject.add_piece_to_column(0, 'R')
        expect(subject.horizontal_highest_piece(0)).to eq(0)
      end
    end
  end

  describe '.move' do

    context 'when column is valid' do
      it 'returns true' do
        allow(subject).to receive(:add_piece_to_column)
        expect(subject.move(0, 'R')).to be_truthy
      end
    end

    context 'when column is invalid' do
      it 'returns false' do
        expect(subject.move(10, 'R')).to be_falsey
      end
    end
  end

  describe '.valid_columns' do

    it 'returns valid columns' do
      subject.move(2, 'R')
      subject.move(2, 'R')
      subject.move(2, 'R')
      subject.move(2, 'R')
      subject.move(2, 'R')
      subject.move(2, 'R')
      expect(subject.valid_columns).to eq ([0, 1, 3, 4, 5, 6])
    end
  end

  describe '.winner' do
    let(:horizontal_board_win) { [["O", "O", "O", "O", "O", "O", "O"],
                                  ["O", "O", "O", "O", "O", "O", "O"],
                                  ["O", "O", "O", "O", "O", "O", "O"],
                                  ["O", "O", "O", "O", "O", "O", "O"],
                                  ["O", "O", "O", "O", "O", "O", "O"],
                                  ["R", "R", "R", "R", "O", "O", "O"]] }

    let(:vertical_board_win) { [["O", "O", "O", "O", "O", "O", "O"],
                                ["O", "O", "O", "O", "O", "O", "O"],
                                ["Y", "O", "O", "O", "O", "O", "O"],
                                ["Y", "O", "O", "O", "O", "O", "O"],
                                ["Y", "O", "O", "O", "O", "O", "O"],
                                ["Y", "O", "O", "O", "O", "O", "O"]] }

    let(:diagonal_board_win) { [["O", "O", "O", "Z", "O", "O", "O"],
                                ["O", "O", "O", "O", "Z", "O", "O"],
                                ["O", "O", "O", "O", "O", "Z", "O"],
                                ["O", "O", "O", "O", "O", "O", "Z"],
                                ["O", "O", "O", "O", "O", "O", "O"],
                                ["O", "O", "O", "O", "O", "O", "O"]] }

    context 'when there is a horizontal winner' do
      it 'returns the value of the winning player' do
        subject.matrix = horizontal_board_win
        expect(subject.winner).to eq('R')
      end
    end

    context 'when there is a vertical winner' do
      it 'returns the value of the winning player' do
        subject.matrix = vertical_board_win
        expect(subject.winner).to eq('Y')
      end
    end

    context 'when there is a diagonal winner' do
      it 'returns the value of the winning player' do
        subject.matrix = diagonal_board_win
        expect(subject.winner).to eq('Z')
      end
    end

  end
end
