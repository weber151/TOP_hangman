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

                    GUESS THE WORD
                    #{@word}

            Letters : #{@letters}
            Guessed : #{@guessed_letters}
        DISPLAY

    end
end

