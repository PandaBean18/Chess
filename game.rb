require_relative "board"
require_relative "display"
class Game 
    attr_reader :player1, :player2, :game_over
    def initialize(player1, player2)
        @board = Board.new 
        @display = Display.new(@board)
        @player1 = [player1, :white]
        @player2 = [player2, :black]
        @current_player =  @player1[0]
        @game_over = false 
    end 

    def play 
        start_pos = nil 
        end_pos = nil 
        while true
            @display.render  
            inp = @display.cursor.get_input
            if inp  && !start_pos
                if @board[inp].class == NullPiece
                    puts "Please select a position with a piece."
                    @display.cursor_selected = false
                    redo 
                else
                    start_pos = inp
                end
            elsif inp && !end_pos 
                end_pos = inp
                #break
            end 
            if start_pos && end_pos && !@board[start_pos].valid_moves.include?(end_pos)
                @board.move_piece(start_pos, end_pos)
                p start_pos
                p end_pos
                p @board[start_pos].valid_moves
                end_pos = nil 
                @display.cursor_pos = start_pos
                start_pos = nil
                @display.cursor_selected = false
                redo
            elsif start_pos && end_pos
                break 
            end      
            system("clear")
        end 
        @board.move_piece(start_pos, end_pos)
        if @current_player == @player1[0] && @board.checkmate?(@player2[1])
            puts "#{@player2[0]} is in check."
            puts "#{@current_player} wins."
            @game_over = true
        elsif @current_player == @player2[0] && @board.checkmate?(@player1[1])
            puts "#{@player1[0]} is in check."
            puts "#{@current_player} wins."
            @game_over = true
        else  
            self.swap_players
        end
    end 

    private 

    def swap_players
        if @current_player == @player1[0]
            @current_player = @player2[0]
            @display.cursor_pos = [0, 0]
        else
            @current_player = player1[0]
            @display.cursor_pos = [7, 7]
        end

        @display.cursor_selected = false
        self.notify_players
    end

    def notify_players
        system("clear")
        puts "It is #{@current_player}'s turn."
    end 

end 
puts "Please type the name of the first player."
p1 = gets.chomp 
puts "Please type the name of the first player."
p2 = gets.chomp
game = Game.new(p1, p2)
puts "It is #{game.player1[0]}'s turn."
while !game.game_over
    game.play 
end

