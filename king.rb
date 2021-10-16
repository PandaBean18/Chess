require_relative "stepable"
class King < Piece 
    include Stepable
    def symbol 
        return :K 
    end 

    def move_diffs
        return [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, -1], [-1, 1]]
    end 
end 