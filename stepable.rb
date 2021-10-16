module Stepable 
    def moves 
        arr = []
        self.move_diffs.each do |x|
            i = self.pos[0] + x[0]
            j = self.pos[1] + x[1]
            if self.board.valid_pos?([i, j]) && (self.board[[i, j]].class == NullPiece || self.board[[i, j]].color != self.color)
                arr << [i, j]
            end 
        end 
        return arr 
    end 

    private 

    def move_diffs
        arr = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, -1], [-1, 1]]
        return arr
    end
end 