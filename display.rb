module Hangman_Display
    def start_screen_question
        system('clear')
        puts <<-DISPLAY
        
            WELCOME TO HANGMAN
            ...
            DO YOU WANT TO START A 

                (N) NEW GAME 
                      OR 
                (L) LOAD EXISTING?
            
            N/L...
        DISPLAY
    end

    def screengame
        system('clear')
        puts <<-DISPLAY

                    GUESS THE WORD --
                                  #{convert(word_guess)}
            
            Errors   #{@guessed_letters.length}/6  : -#{"X" * @guessed_letters.length}-
            Letters       :#{convert(@letters)}
            Guessed       :#{convert(@guessed_letters)}

Enter "!" -- to save and exit.
        DISPLAY

    end

    def convert(array)
        array.to_s.gsub(/["\[\]]/, " ")
    end

    def end_game_lose
        puts <<-DISPLAY

    -- LOSER -- LOSER -- LOSER -- LOSER -- LOSER --

        DISPLAY
    end

    def end_game_win
        puts <<-DISPLAY

    -- WINNER -- WINNER -- WINNER -- WINNER -- WINNER --

        DISPLAY
        exit
    end

end

