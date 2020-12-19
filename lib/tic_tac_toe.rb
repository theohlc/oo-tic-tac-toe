require "pry"

class TicTacToe
    attr_reader :board

    WIN_COMBINATIONS = [
        [0,1,2],  # Top row
        [3,4,5],  # Middle row
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(s)
        s.to_i - 1
    end

    def move(index, token = "X")
        board[index] = token
    end

    def position_taken?(index)
        board[index] == "X" || board[index] == "O"
    end

    def valid_move?(index)
        8 >= index && index >= 0 && !position_taken?(index) 
    end

    def turn_count
        count = 0
        index = 0
        while index < 9
            count += 1 if position_taken?(index)
            index += 1
        end
        count
    end

    def current_player
        player = "O"
        #binding.pry
        player = "X" if turn_count.even?
        player
    end

    def turn
        #display_board
        puts "Your move...>"
        #user_move = String.new
        user_move = gets.chomp
        index = input_to_index(user_move)
        if valid_move?(index)
            move(index, current_player)
            #binding.pry
            display_board
        else
            puts "Invalid move"
            turn
        end

    end

    def won?
        @winner = nil
        winning_combo = nil
        WIN_COMBINATIONS.each do |combo|
            #binding.pry if combo == [0,4,8] 
            if "X" == board[combo[0]] && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
                winning_combo = combo
                @winner = "X"
            elsif "O" == board[combo[0]] && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
                winning_combo = combo
                @winner = "O"
            else
            end
        end
        #binding.pry
        winning_combo
    end

    def full?
        turn_count == 9
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        @winner = nil
        winning_combo = nil
        WIN_COMBINATIONS.each do |combo|
            #binding.pry if combo == [0,4,8] 
            if "X" == board[combo[0]] && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
                winning_combo = combo
                @winner = "X"
            elsif "O" == board[combo[0]] && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
                winning_combo = combo
                @winner = "O"
            else
            end
        end
        #binding.pry
        @winner
    end

    def play 
        until over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

end