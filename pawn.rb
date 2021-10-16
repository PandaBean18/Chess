require_relative "slideable"
class Pawn < Piece 
    def symbol
        return :P 
    end 

    def moves 
        arr = [] 
        i = self.pos[0]
        j = self.pos[1]
        if self.at_front_row? && @board[[(i + (self.forward_dir * 2)), j]].class == NullPiece
            arr << [(i + self.forward_dir), j]
            arr << [(i + (self.forward_dir * 2)), j]
        else
            arr << [(i + self.forward_dir), j]
        end
        arr += self.side_attacks
        return arr 
    end 

    private

    def forward_dir
        if self.color == :black
            return 1 
        else 
            return -1
        end 
    end

    def at_front_row?
        if self.color == :black && self.pos[0] == 1
            return true 
        elsif self.color == :white && self.pos[0] == 6
            return true 
        else 
            return false
        end
    end

    def side_attacks
        dirs = [[forward_dir, -1], [forward_dir, 1]]
        attacks = []
        dirs.each do |x|
            i = self.pos[0] + x[0]
            j = self.pos[1] + x[1]
            if self.board.valid_pos?([i, j]) && self.board[[i, j]].class != NullPiece && self.board[[i, j]].color != self.color 
                attacks << [i, j]
            end 
        end 
        return attacks
    end
end 