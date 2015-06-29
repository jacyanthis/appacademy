def guessing_game
    num = rand(100)
    tries = 0
    puts "Please guess a number between 1 and 100 (inclusive)!"
    correct = false
    while correct == false
        guess = gets.chomp.to_i
        tries += 1
        if guess == num
            if tries == 1
                puts "Wow! You got it on your first try."
                correct = true
            else
                puts "Great! You got it in #{tries} tries!"
                correct = true
            end
        elsif guess > num
            puts "Sorry, that's too high! Try again."
        elsif guess < num
            puts "Sorry, that's too low! Try again."
        end
    end
end

guessing_game
