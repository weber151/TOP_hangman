def guess_valid?(guess)
    # Checks for valid_guess for hangman game
    letters = %w(a b c d e f g h i j k l m n o p q r s t - v w x y z)
    guess.length == 1 && guess.match?(/[a-z]/) && letters.include?(guess)
end

def get_guess
    loop do
        puts "Guess a letter in the word..."
        guess = gets.chomp
        break if guess_valid?(guess)
    end 
    puts "good guess!"           
end

get_guess


