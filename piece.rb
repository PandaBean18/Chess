class Piece
    attr_reader :color, :board, :pos
    def initialize(color, board, pos)
        @color = color 
        @board = board 
        @pos = pos 
    end

    def pos=(val)
        @pos = val 
    end

    def valid_moves
        arr = []
        self.moves.each do |x|
            if !self.move_into_check?(x)
                arr << x
            end 
        end 
        return arr 
    end

    private 

    def move_into_check?(end_pos)
        dup_board = @board.dup 
        dup_board.move_piece!(@pos, end_pos)
        return dup_board.in_check?(@color)
    end
    
end 