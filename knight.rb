require_relative "stepable"
class Knight < Piece
    include Stepable
    
    def symbol 
        return :H  
    end 

    def move_diffs
        arr = [
            [2, 1],
            [2, -1],
            [-2, 1],
            [-2, -1],
            [1, 2],
            [-1, 2],
            [1, -2], 
            [-1, -2]
        ]
        return arr 
    end
end 