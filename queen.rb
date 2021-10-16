require_relative "slideable"
class Queen < Piece 
    include Slideable

    def symbol
        return :Q 
    end

    private

    def move_dirs
        [:Horizontal, :Diagonal, :Vertical]
    end
end