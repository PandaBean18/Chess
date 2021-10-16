require_relative "slideable"
class Bishop < Piece 
    include Slideable
    
    def symbol
        return :B   
    end

    private 

    def move_dirs
        [:Diagonal]
    end
end