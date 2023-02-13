require './display.rb'
require 'json'


module Hangman_Mechanics

    def pickword
        # Picks a random word from the .txt file provided through THE ODIN PROJECT
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
        # Checks for valid_guess for hangman game
       guess.downcase =~ /[a-z]/ ? true : false
    end

    def save_game(word, word_guess, word_array, letters, guessed_letters)
        # Creates a save game to a "Saves" folder
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
        # Allows player to choose to load a game or start a new game
        load_or_new = ""
        load_or_new = "N" unless Dir.exists?("./Saves")
        while /[NnLl]/.match?(load_or_new) == false
            puts "please enter valid response (N/L)..."
            load_or_new = gets.chomp
        end
        if /\A[nN]/.match?(load_or_new)
            system('clear')
            return "new"
        elsif /\A[lL]/.match?(load_or_new)
            system('clear')
            return "load"
        end
    end

    def loadgame_choice
        #Provides player with the loadgame choices
        saves_to_load = Dir.new("./Saves").entries.select {|entry| entry.match?(/\A[.]/) == false}
        saves_to_load.each_with_index {|entry, i| puts "(#{i}) #{entry}"}
        puts "Please choose a loadgame by number..."
        load_selection = gets.chomp
        saves_to_load.entries.each_with_index do |entry, i|
            if load_selection == i.to_s
                puts "#{entry} -- selected...please wait..."
                sleep 2
                system('clear')
                load_game(entry)
            end
        end

    end

    def load_game(entry)
        #Loads file to game for play

        loadfile = File.new("./Saves/#{entry}", "r")
        load_file_passing_array = [] 
        loadfile.each_with_index do |line, i|
            line = line.chomp
            line = JSON.parse(line) unless i == 0
            load_file_passing_array << line
        end
        # Assigning values through array !! CONSIDER a more optimal way to do this?
        @word = load_file_passing_array[0]
        @word_array = load_file_passing_array[1]
        @word_guess = load_file_passing_array[2]
        @letters = load_file_passing_array[3]
        @guessed_letters = load_file_passing_array[4]
    end

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
        start_screen_question # Main-Menu
        game_type = load_or_new #Player chooses to start new or load existing
        loadgame_choice unless game_type == "new" # Load existing, if chosen
        screengame # start game

        # save_game(@word, @word_guess, @word_array, @letters, @guessed_letters)
    end

end


first_game = Game.new
# first_game.game_start
first_game.game_start
