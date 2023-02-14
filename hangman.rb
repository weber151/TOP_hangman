require './display.rb'
require 'json'
require './hangman_mechanics.rb'

class Game
    include Hangman_Display
    include Hangman_Mechanics
    
    attr_accessor :word, :word_array, :word_guess, :letters, :guessed_letters

    def initialize
        @word = pickword
        @word_guess = Array.new(@word.length, "_")
        @word_array = word.split('')
        @letters = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
        @guessed_letters = []
    end

    def game_start
        start_screen_question # Main-Menu
        game_type = load_or_new #Player chooses to start new or load existing
        loadgame_choice unless game_type == "new" # Load existing, if chosen
        play_game
    end

end


first_game = Game.new
# first_game.game_start
first_game.game_start
