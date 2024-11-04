# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

#########################################################################
# TODO: Fix 3-corner piece
# Fix board fill forall pieces
#
#########################################################################

class MyPiece < Piece
    # The constant All_My_Pieces should be declared here
    All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
               rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
               [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
               [[0, 0], [0, -1], [0, 1], [0, 2]]],
               rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
               rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
               rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
               rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
               [[[0, 0],[-1, 0],[-2, 0],[1, 0],[2, 0]],
                [[0, 0],[0, -1],[0, -2],[0, 1],[0, 2]]], # five-long
               rotations([[0, 0],[1, 0],[0, -1],[-1, -1],[-1, 0]]), # Thumbs-up
               rotations([[0, 0],[1, 0],[0, -1]])] # 3-corner

    # your enhancements here
    
    def self.next_piece (board)
      if board.cheating
        board.cheating = false
        return MyPiece.new([[[0, 0]]], board)
      else
        MyPiece.new(All_My_Pieces.sample, board)
      end
    end
  
  end
  
  class MyBoard < Board

    attr_accessor :cheating

    def initialize (game)
      @grid = Array.new(num_rows) {Array.new(num_columns)}
      @current_block = MyPiece.next_piece(self)
      @score = 0
      @game = game
      @delay = 500
      @cheating = false
    end

    def store_current
      locations = @current_block.current_rotation
      displacement = @current_block.position
      (0..(locations.size-1)).each{|index| 
        current = locations[index];
        @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
        @current_pos[index]
      }
      remove_filled
      @delay = [@delay - 2, 80].max
    end

    def rotate_180
      if !game_over? and @game.is_running?
        @current_block.move(0, 0, 2)
      end
      draw
    end

    def next_piece
      @current_block = MyPiece.next_piece(self)
      @current_pos = nil
    end

    def cheat_btn
      if (@score >= 100) and !cheating
        @score -= 100
        @cheating = true
      end
    end
  end
  
  
  class MyTetris < Tetris
    def set_board
      @canvas = TetrisCanvas.new
      @board = MyBoard.new(self)
      @canvas.place(@board.block_size * @board.num_rows + 3,
                    @board.block_size * @board.num_columns + 6, 24, 80)
      @board.draw
    end
    
    def key_bindings
      super
      @root.bind('u', proc {@board.rotate_180})
      
      @root.bind('c', proc {@board.cheat_btn})
    end
  
  end

  