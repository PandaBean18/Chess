require_relative "slideable"
class Rook < Piece 
    include Slideable

    def symbol
        return :R 
    end

    private 

    def move_dirs 
        return [:Horizontal, :Vertical]
    end 
end