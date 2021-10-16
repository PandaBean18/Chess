require_relative "cursor.rb"
require "colorize"
class Display
    attr_reader :cursor
    def initialize(board)
        @board = board
        @cursor = Cursor.new([7, 7], board)
    end

    def render 
        puts "  A B C D E F G H"
        @board.rows.each.with_index do |subarr, i|
            print (8 - i).to_s
            subarr.each.with_index do |x, j|
                piece_color = @board[[i, j]].color
                if (i + j) % 2 == 0 
    
                    color = {background: :light_blue, color: piece_color}
                else
                    color = {background: :blue, color: piece_color}
                end
                if [i, j] == @cursor.cursor_pos && @cursor.selected
                    color = {background: :green, color: piece_color}
                elsif [i, j] == @cursor.cursor_pos
                    color = {background: :red, color: piece_color}
                end
                print x.symbol.to_s.colorize(color)
                print " ".colorize(color)
            end 
            puts "\n"
        end
    end

    def cursor_pos=(val)
        @cursor.cursor_pos = val 
    end

    def cursor_selected=(val)
        @cursor.selected = val 
    end
end