require_relative "piece"
require_relative "rook"
require_relative "bishop"
require_relative "queen"
require_relative "nullpiece"
require_relative "pawn"
require_relative "display"
require_relative "knight"
require_relative "king"
class Board 
    attr_reader :rows
    def initialize 
        @rows = Array.new(8) {Array.new(8, NullPiece.instance)}
        i = 0
        while i < 8
            @rows[1][i] = Pawn.new(:black, self, [1, i])
            @rows[6][i] = Pawn.new(:white, self, [6, i])
            i += 1
        end

        @rows[7][0] = Rook.new(:white, self, [7, 0])
        @rows[7][1] = Knight.new(:white, self, [7, 1])
        @rows[7][2] = Bishop.new(:white, self, [7, 2])
        @rows[7][3] = Queen.new(:white, self, [7, 3])
        @rows[7][4] = King.new(:white, self, [7, 4])
        @rows[7][5] = Bishop.new(:white, self, [7, 5])
        @rows[7][6] = Knight.new(:white, self, [7, 6])
        @rows[7][7] = Rook.new(:white, self, [7, 7])

        @rows[0][0] = Rook.new(:black, self, [0, 0])
        @rows[0][1] = Knight.new(:black, self, [0, 1])
        @rows[0][2] = Bishop.new(:black, self, [0, 2])
        @rows[0][3] = Queen.new(:black, self, [0, 3])
        @rows[0][4] = King.new(:black, self, [0, 4])
        @rows[0][5] = Bishop.new(:black, self, [0, 5])
        @rows[0][6] = Knight.new(:black, self, [0, 6])
        @rows[0][7] = Rook.new(:black, self, [0, 7])
    end 


    def [](pos)
        return @rows[pos[0]][pos[1]]
    end

    def []=(pos, val)
        @rows[pos[0]][pos[1]] = val
    end

    def move_piece(start_pos, end_pos)
        if self[start_pos].class == NullPiece
            puts "No piece at #{start_pos}"
        elsif !(end_pos.all? {|x| x.between?(0, 7)})
            puts "Can not move to #{end_pos}"
        end

        if self[start_pos].moves.include?(end_pos) && !self[start_pos].valid_moves.include?(end_pos)
            puts "You can not move to #{end_pos} as it will leave you in check."
        elsif self[start_pos].moves.include?(end_pos)
            piece = self[start_pos]
            self[start_pos] = NullPiece.instance
            self[end_pos] = piece
            piece.pos = end_pos
        else
            puts "You can not move to #{end_pos}."
        end 
    end

    def move_piece!(start_pos, end_pos)
        if self[start_pos].class == NullPiece
            raise "No piece at #{start_pos}"
        elsif !(end_pos.all? {|x| x.between?(0, 7)})
            raise "Can not move to #{end_pos}"
        end

        if self[start_pos].moves.include?(end_pos)
            piece = self[start_pos]
            self[start_pos] = NullPiece.instance
            self[end_pos] = piece
            piece.pos = end_pos
        else
            raise "You can not move to #{end_pos}"
        end 
    end

    def valid_pos?(pos)
        if pos.all? {|x| x.between?(0, 7)}
            return true 
        else 
            return false
        end
    end

    def in_check?(color)
        king_pos = self.find_king(color)
        @rows.each do |subarr|
            subarr.each do |x|
                if x.class != NullPiece && x.color != color && x.moves.include?(king_pos)
                    return true 
                end 
            end 
        end
        return false 
    end

    def find_king(color)
        king_pos = nil 
        @rows.each.with_index do |subarr, i|
            subarr.each.with_index do |piece, j|
                if piece.class == King && piece.color == color
                    king_pos = [i, j]
                end
            end
        end
        return king_pos
    end

    def attacking_pieces(color)
        arr = []
        @rows.each do |subarr|
            subarr.each do |x|
                if x.class != NullPiece && x.color != color && x.moves.include?(find_king(color))
                    arr << x
                end 
            end
        end
        return arr 
    end

    def trace_path(piece1, piece2)
        arr = []
        piece1_pos = piece1.pos
        piece2_pos = piece2.pos
        if piece1_pos[0] == piece2_pos[0]
            forward = nil
            if piece1_pos[1] > piece2_pos[1]
                forward = -1
            else 
                forward = 1
            end 
            i = piece1_pos[1] + forward
            j = piece2_pos[1]

            while i > j
                arr << [piece1_pos[0], i]
                i += forward
            end 
        elsif piece1_pos[1] == piece2_pos[1]
            forward = nil
            if piece1_pos[0] > piece2_pos[0]
                forward = -1
            else 
                forward = 1
            end 
            i = piece1_pos[0] + forward
            j = piece2_pos[0]
            while i > j
                arr << [i, piece1_pos[1]]
                i += forward
            end 
        else
            dx = nil
            dy = nil 
            x = piece1_pos[0]
            y = piece1_pos[1]
            if piece1_pos[0] - piece2_pos[0] > 0
                dx = -1 
            else 
                dx = 1
            end 

            if piece1_pos[1] - piece2_pos[1] < 0
                dy = 1
            else
                dy = -1
            end 

            until x == piece2_pos[0] || y == piece2_pos[1]
                arr << [x, y]
                x += dx
                y += dy 
            end 
        end 
        return arr
    end

    def can_be_blocked?(attacking_piece, secondary_piece, color_attack_piece = attacking_piece.color)
        if attacking_piece.class.included_modules.include?(Stepable)
            return false 
        end
        @rows.each do |subarr|
            subarr.each do |x|
                if x.class != NullPiece && x.class != King && x.color != color_attack_piece && trace_path(attacking_piece, secondary_piece).any? {|pos| x.moves.include?(pos)} 
                    return true 
                end 
            end 
        end
        return false 
    end

    def checkmate?(color)
        if !self.in_check?(color)
            return false 
        end
        attacking_pieces_array = self.attacking_pieces(color)
        if attacking_pieces_array.length == 0
            return false 
        elsif attacking_pieces_array.length == 1
            if self[find_king(color)].moves.empty?
                return true 
            end
            @rows.each do |subarr|
                if subarr.any? {|x| x.color == color && x.moves.include?(attacking_pieces_array[0].pos)}
                    return false 
                elsif subarr.any? {|x| x.class != NullPiece && x.color == color && self.can_be_blocked?(attacking_pieces_array[0], x)}
                    return false 
                end 
            end 
        else 
            if !self[self.find_king(color)].moves.empty?
                return false 
            end 
        end
        return true 
    end 

    def dup
        dup_board = Board.new
        i = 0
        while i < 8 
            j = 0 
            while j < 8
                piece = self[[i, j]]
                piece_class = piece.class 
                color = piece.color
                if piece_class == NullPiece
                    dup_board[[i, j]] = NullPiece.instance
                else
                    dup_board[[i, j]] = piece_class.new(color, dup_board, [i, j])
                end
                j += 1
            end 
            i += 1
        end 
        return dup_board
    end 
end

