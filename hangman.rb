require './display.rb'


module Hangman_Mechanics

    def pickword
        wordlist_file = File.open("./google-10000-english-no-swears.txt", "r")
        word_array = []
        wordlist_file.each do |line|
            word_array << line
        end
        word_valid = false
        while word_valid == false
            word = word_array[rand(word_array.length + 1)]
            if word.length > 6 && word.length < 12
                return word.chomp
                word_valid = true
            end
        end
    end

    def guess_valid?(guess)
       guess.downcase =~ /[a-z]/ ? true : false
    end

    def save_game(word, word_guess, word_array, letters, guessed_letters)
        save_info = [word, word_guess, word_array, letters, guessed_letters]
        Dir.mkdir("./Saves") unless Dir.exists?("./Saves")
        puts "Name of savefile..."
        save_name = gets.chomp.upcase
        new_save = File.open("./Saves/#{save_name}.txt", "w")
        save_info.each do |var|
            new_save.puts var.to_s
        end
        new_save.close
    end

    def load_or_new
        load_or_new = ""
        load_or_new = "N" unless Dir.exists?("./Saves")
        while /[NnLl]/.match?(load_or_new) == false
            puts "please enter valid response (N/L)..."
            load_or_new = gets.chomp
        end
        if /\A[nN]/.match?(load_or_new)
            screengame
            # save_game(@word, @word_guess, @word_array, @letters, @guessed_letters)
        elsif /\A[lL]/.match?(load_or_new)
            puts "loading game"
        end
    end

    def loadgame

        Dir.glob

end

class Game
    include Hangman_Display
    include Hangman_Mechanics
    
    attr_accessor :word, :word_array, :word_guess, :letters, :guessed_letters

    def initialize
        @word = pickword
        @word_array = word.split('')
        @word_guess = Array.new(@word.length, "_")
        @letters = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
        @guessed_letters = []
    end

    def game_start
        start_screen_question
        load_or_new
    end

end


first_game = Game.new
# first_game.game_start
first_game.game_start
