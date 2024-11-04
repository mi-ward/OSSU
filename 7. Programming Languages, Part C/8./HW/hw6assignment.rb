# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  def initialize (point_array, board)
    super(point_array, board)
  end

  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  def self.cheat_piece (board)
    MyPiece.new([[[0,0]]], board)
  end

  All_My_Pieces = Piece::All_Pieces + [[[[0, 0], [-1, 0], [1, 0], [-2, 0], [2, 0]], # long (only needs two)
                                        [[0, 0], [0, -1], [0, 1], [0, -2], [0, 2]]],
                                        rotations([[0,0], [0,-1], [1,0]]), #small L
                                        rotations([[0,0], [-1, 0], [1, 0], [-1, -1], [0,-1]])] #square+1
end

class MyBoard < Board
  def initialize (game)
    super(game)
    @current_block = MyPiece.next_piece(self)
    @cheat_piece_active = false
  end

  # rotates the current piece clockwise
  def rotate_one_eighty
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end

  def trigger_cheat_piece
    if !game_over? and @game.is_running? and (@score >= 100) and !@cheat_piece_active
      @cheat_piece_active = true
      @score -= 100
    end
  end

  def next_piece
    if @cheat_piece_active
      @current_block = MyPiece.cheat_piece(self)
      @cheat_piece_active = false
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

  # gets the information from the current piece about where it is and uses this
  # to store the piece on the board itself.  Then calls remove_filled.
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..(@current_block.current_rotation.length() - 1)).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
end

class MyTetris < Tetris
  def initialize
    super
  end

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
  
  def key_bindings
    super
    @root.bind('u' , proc {@board.rotate_one_eighty}) 
    @root.bind('c', proc {@board.trigger_cheat_piece})
  end
end


