class Mastermind
    
    attr_reader :n, :target_code, :colors, :max_guesses
    
    def initialize
        
        
        puts "How many pegs? "
        n = gets.chomp.to_i
    
        @n = n
        @target_code = Code.new(n)
        @max_guesses = 2 * n + 2
        puts "Display will be:"
        puts " " * 6 + "#_hits"
        puts "<code>"
        puts " " * 6 + "#_misses"
        play
    end
    
    def play
        guess_count = 0
        won = false
        # TA: I think #won? should be a method, rather than a variable
        until won || guess_count == max_guesses
            # TA: I would extract this logic to another method (maybe #over?)
            puts "What's your guess?"
            guess_code = Code.new(n,  gets.chomp.upcase.split(""))
            num_hits = target_code.hits(guess_code)
            num_misses = target_code.misses(guess_code)
            won = show_result(guess_code, num_hits, num_misses)
        end
        if won
            # TA: I'd also like to see this in a helper method: maybe #game_over
            puts "You won in #{guess_count} guesses!"
        else
            puts "You lose!"
            puts "Target was:"
            puts target_code.join
        end
        
    end
    
    def show_result(guess_code, num_hits, num_misses)
        puts " " * n + num_hits.to_s
        puts guess_code.code.join
        puts " " * n + num_misses.to_s

        num_hits == n
    end
    
end

class Code
    
    attr_reader :colors, :code, :n, :color_occurrences
    
    def initialize(n, code = nil)
        @n = n
        @colors = ["R","B","G","Y","O","P"]
        if !code
            instantiate_target(n)
        else
            @code = code
            @color_occurrences = nil
        end
    end
    
    def instantiate_target(n)
        @code = Array.new(n)
        (0...n).each do |i|
            @code[i] = colors[i]
        end
        @color_occurrences = {}
        set_color_occurrences
    end
    
    def set_color_occurrences
        @code.each do |color|
            if @color_occurrences[color]
                @color_occurrences[color] += 1
            else
                @color_occurrences[color] = 1
            end
        end 
    end
    
    def [](index)
        code[index]
        # TA: This is good. :)
    end
    
    def hits(guess_code)
        (0...n).select { |i| guess_code[i] == self[i] }.size
        # TA: Nice.
    end
    
    def misses(guess_code)
        occurrences = color_occurrences.dup
        guess_code.code.select do |color|
            if !occurrences[color] || occurrences[color] == 0
                false
            else
                occurrences[color] -= 1
                true
            end
        end.size - hits(guess_code)
    end
    
end

Mastermind.new