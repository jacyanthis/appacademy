def rps(user_choice)
    choices = [
        "Rock",
        "Paper",
        "Scissors"
        ]
    winning_combinations = [
        ["Rock","Scissors"],
        ["Scissors", "Paper"],
        ["Paper", "Rock"]
        ]
    computer_idx = rand(0..2)
    computer_choice = choices[computer_idx]
    if user_choice == computer_choice
        "#{computer_choice}, Draw"
    elsif winning_combinations.include?([user_choice,computer_choice])
        "#{computer_choice}, Win"
    else
        "#{computer_choice}, Loss"
    end
end

puts(rps("Rock"))
puts(rps("Scissors"))
puts(rps("Paper"))