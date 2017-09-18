class Board
  attr_accessor :matrix

  ROWS = 6
  COLUMNS = 7

  def initialize
    @matrix = Array.new(ROWS) { Array.new(COLUMNS, 'O') }
  end

  def add_piece_to_column(column, piece)
    top_index = horizontal_highest_piece(column)
    return nil if top_index == 0
    @matrix[top_index-1][column] = piece
  end

  def horizontal_highest_piece(column)
    @matrix.map { |row| row[column] }.index { |char| char != 'O' } || @matrix.length
  end

  def move(input, piece)
    if valid_columns.include?(input)
      add_piece_to_column(input, piece)
      true
    else
      puts 'Invalid Move!'
      false
    end
  end

  def display
    puts (0..ROWS-1).map{|row| @matrix[row].join(' ') }
  end

  def valid_columns
    columns = []
    (0..COLUMNS-1).map { |column| columns << column if @matrix.first[column] == 'O' }
    columns
  end

  def winner
    horizontal_winner || vertical_winner || diagonal_winner
  end

  private

  def horizontal_winner
    @matrix.reduce(nil) { |winner, row| winner || get_winner(row) }
  end

  def vertical_winner
    (0..COLUMNS-1).reduce(nil) { |winner, col| winner || get_winner((0..ROWS-1).map { |row| @matrix[row][col] }) }
  end

  def get_winner(row)
    winning_chunk = row.chunk(&:itself).detect do |chunk|
      chunk[0] != 'O' && chunk[1].length >= 4
    end
    winning_chunk ? winning_chunk[0] : nil
  end

  def diagonal_winner
    (ROWS-1).downto(ROWS-3).reduce(nil) do |winner, row|
      return winner unless winner.nil?
      winner ||= get_winner(row.downto(0).map { |current_row| @matrix[current_row][row - current_row] })
      winner ||= get_winner(row.downto(0).map { |current_row| @matrix[current_row][current_row + ROWS - row] })

      row_repeater = ROWS-1
      column_repeater = row_repeater + (ROWS - row)
      winner ||= get_winner(row_repeater.downto(row_repeater-row).map { |current_row| @matrix[current_row][column_repeater - current_row] } )
      winner ||= get_winner(row_repeater.downto(row_repeater-row).map { |current_row| @matrix[current_row][current_row + ROWS - column_repeater] } )
      winner
    end
  end

end
