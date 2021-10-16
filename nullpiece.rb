require "singleton"
class NullPiece < Piece
    include Singleton
    
    def initialize
    end 
    
    def symbol 
        return " "
    end
end