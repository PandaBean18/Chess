module Slideable

    def horizontal_dirs
        arr = []
        if self.move_dirs.include?(:Horizontal)
            i = self.pos[0] - 1
            until i == -1
                if self.board[[i, self.pos[1]]].class != NullPiece && self.board[[i, self.pos[1]]].color == self.color 
                    break 
                elsif self.board[[i, self.pos[1]]].class != NullPiece
                    arr << [i, self.pos[1]]
                    break
                end 

                arr << [i, self.pos[1]]
                i -= 1
            end 

            j = self.pos[0] + 1

            until j == 8
                if self.board[[j, self.pos[1]]].class != NullPiece && self.board[[j, self.pos[1]]].color == self.color 
                    break 
                elsif self.board[[j, self.pos[1]]].class != NullPiece
                    arr << [j, self.pos[1]]
                    break
                end
                
                arr << [j, pos[1]]
                j += 1
            end
        end 
        return arr 
    end 

    def vertical_dirs
        arr = []
        if self.move_dirs.include?(:Vertical)
            i = self.pos[1] - 1
            until i == -1
                if self.board[[self.pos[0], i]].class != NullPiece && self.board[[self.pos[0], i]].color == self.color 
                    break 
                elsif self.board[[self.pos[0], i]].class != NullPiece
                    arr << [self.pos[0], i]
                    break
                end 

                arr << [self.pos[0], i]
                i -= 1
            end 

            j = self.pos[1] + 1

            until j == 8
                if self.board[[self.pos[0], j]].class != NullPiece && self.board[[self.pos[0], j]].color == self.color 
                    break 
                elsif self.board[[self.pos[0], j]].class != NullPiece
                    arr << [self.pos[0], j]
                    break
                end
                
                arr << [self.pos[0], j]
                j += 1
            end
        end 
        return arr 
    end 


    def diagonal_dirs
        arr = []
        if self.move_dirs.include?(:Diagonal)
            i = self.pos[0] + 1
            j = self.pos[1] + 1
            until i == 8 || j == 8
                if self.board[[i, j]].class != NullPiece && self.board[[i, j]].color == self.color 
                    break 
                elsif self.board[[i, j]].class != NullPiece
                    arr << [i, j]
                    break
                end 
                arr << [i, j]
                i += 1
                j += 1
            end

            a = self.pos[0] - 1
            b = self.pos[1] - 1

            until a == -1 || b == -1 
                if self.board[[a, b]].class != NullPiece && self.board[[a, b]].color == self.color 
                    break
                elsif self.board[[a, b]].class != NullPiece
                    arr << [a, b]
                    break 
                end 

                arr << [a, b]
                a -= 1
                b -= 1
            end 

            k = self.pos[0] - 1
            l = self.pos[1] + 1

            until k == -1 || l == 8
                if self.board[[k, l]].class != NullPiece && self.board[[k, l]].color == self.color 
                    break 
                elsif self.board[[k, l]].class != NullPiece
                    arr << [k, l]
                end

                arr << [k, l]
                k -= 1
                l += 1
            end

            x = self.pos[0] + 1
            y = self.pos[1] - 1

            until x == 8 || y == -1
                if self.board[[x, y]].class != NullPiece && self.board[[x, y]].color == self.color 
                    break 
                elsif self.board[[x, y]].class != NullPiece
                    arr << [x, y]
                    break 
                end 
                arr << [x, y]
                x += 1
                y -= 1
            end 
        end 
        return arr
    end

    def moves 
        moves = self.horizontal_dirs + self.vertical_dirs + self.diagonal_dirs
        return moves
    end

    private

    def move_dirs
        return [:Horizontal, :Diagonal]
    end
end
