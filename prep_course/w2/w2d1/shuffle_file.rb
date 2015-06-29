def shuffle_file
    puts "Which file would you like to shuffle?"
    file = gets.chomp
    File.open(file + "-shuffled.txt", "w") do |f|
        f.puts(File.readlines(file).shuffle)
    end
end