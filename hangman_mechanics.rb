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

    def play_game
        while @guessed_letters.length < 6
            begin
                screengame
                end_game_win unless @word_guess.include?("_")
                puts "Guess a letter in the word..."
                guess = gets.chomp 
                if guess == "!"
                    save_game(@word, @word_guess, @word_array, @letters, @guessed_letters)
                    abort("thanks for playing!")
                end
            end while guess_valid?(guess) == false # loop "guess-a-letter" if input invalid
            @letters.map! {|letter| guess == letter ? '-' : letter } # update display letters
            if @word.include?(guess) # check if guess is correct
                @word_array.each_with_index do |letter, index|
                    @word_guess[index] = guess if letter == guess
                end
            else
                @guessed_letters << guess # guess is incorrect - add to list
            end
        end
        end_game_lose
    end

    def guess_valid?(guess)
        # Checks for valid_guess for hangman game
        guess.length == 1 && guess.match?(/[a-z]/) && @letters.include?(guess)
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
        # exit
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
        @word_guess = load_file_passing_array[1]
        @word_array = load_file_passing_array[2]
        @letters = load_file_passing_array[3]
        @guessed_letters = load_file_passing_array[4]
    end

end