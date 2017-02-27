class QueenAttack
  BOARD = "
=================
| | | | | | | | |
+-+-+-+-+-+-+-+-+
| | | | | | | | |
+-+-+-+-+-+-+-+-+
| | | | | | | | |
+-+-+-+-+-+-+-+-+
| | | | | | | | |
+-+-+-+-+-+-+-+-+
| | | | | | | | |
+-+-+-+-+-+-+-+-+
| | | | | | | | |
+-+-+-+-+-+-+-+-+
| | | | | | | | |
+-+-+-+-+-+-+-+-+
| | | | | | | | |
=================
  ".split("\n")

  def initialize(wq_coords, bq_coords)
    new_row = Array.new(8)
    @board = []
    8.times do @board << new_row end;
    @wq = wq_coords
    @bq = bq_coords
  end

  def attack_row?
    return (@wq[:row] == @bq[:row])
  end

  def attack_col?
    return (@wq[:col] == @bq[:col])
  end

  def attack_diag?
    return false if @wq[:row]-@bq[:row] == 0
    return ((@wq[:col]-@bq[:col])/(@wq[:row]-@bq[:row])).abs == 1
  end

  def set_up_board
    board = BOARD
    pos_1 = {row:(@wq[:row])*2, col:(@wq[:col]-1)*2+1}
    board[pos_1[:row]][pos_1[:col]] = 'W'
    pos_2 = {row:(@bq[:row])*2, col:(@bq[:col]-1)*2+1}
    board[pos_2[:row]][pos_2[:col]] = 'B'
    return board
  end

  def self.get_coords(color, valid=false)
    while !valid
      puts "Enter #{color} Queen coordinates as row, column (ex: '1, 3'): "
      coords = STDIN.gets
      valid, msg, coords = QueenAttack.validate_coords(coords)
      puts msg if valid != true
    end
    return coords
  end

  def self.validate_coords(coords)
    return [false, 'Coordinates must be split with one comma.'] if (coords.split(',').count != 2)
    row, col = coords.split(',').map(&:to_i)
    return [false, 'Coordinates must be between 1 and 8.'] if row < 1 || row > 8 || col < 1 || col > 8
    return [true, 'ok', {row:row, col:col}]
  end
end
