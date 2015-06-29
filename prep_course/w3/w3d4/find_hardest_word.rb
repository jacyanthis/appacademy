  def find_hardest_word
    dictionary = load_dictionary
    max_length = dictionary.max_by(&:length).length
    hardest_words = Hash.new
    (1..max_length).each do |length|
      words = dictionary.select { |word| word.length == length }
      info = find_hardest_word_recursive(words, 0, [])
      hardest_words[info[0]] = info[1]
    end
    puts "The hardest words are: #{hardest_words.to_s}"
    puts "The hardest word in the dictionary is: #{hardest_words.max_by{|k,v| v}.to_s}"
  end
  
  def load_dictionary
    dictionary = []
    File.foreach('dictionary.txt') do |line|
        dictionary << line.chomp
    end
    dictionary.select! { |word| word.length == 5 }
  end
  
  def find_hardest_word_recursive(words, steps, letters_checked)
    puts "I'm looking at these words (first 20): #{words[0..20]}"
    puts "In this tree, the AI has guessed: #{letters_checked.to_s}"
    puts "The AI has guessed #{letters_checked.length} letters."
    if words.length == 0
      return ["", 0]
    elsif words.length == 1
      return [words[0], steps]
    else
      letters_and_freq = get_letters_and_freq(words)
      puts "The letters and freqs are: #{letters_and_freq.to_s}"
      hardest_words = {}
      letters_and_freq.each_pair do |letter1, freq1|
        puts "Now, I'm going to investigate: #{letter1}"
        if !letters_checked.include?(letter1)
          more_frequent_letters = letters_and_freq.select do |letter2, freq2|
            freq2 >= freq1 && letter1 != letter2 && !letters_checked.include?(letter2)
          end
          puts "More frequent letters than b are: #{more_frequent_letters.to_s}" if letter1 == "b"
          steps = more_frequent_letters.keys.length
          words2 = words.select { |word| word.include?(letter1) }
          words3 = words2.select do |word|
            has_no_more_frequent_letter = true
            more_frequent_letters.keys.each do |letter3|
              has_no_more_frequent_letter = false if word.include?(letter3)
            end
            has_no_more_frequent_letter
          end
          puts words3.to_s if letter1 == "b"
          #now we have the letter and words that will make the AI guess that letter
          info = find_hardest_word_recursive(words3, steps, letters_checked << letter1)
          hardest_words[info[0]] = info[1]
          puts "The hardest words so far are: #{hardest_words.to_s}"
        end
      end
      puts hardest_words
      return hardest_words.max_by{ |word, int| int}
    end
  end
  
  def get_letters_and_freq(words)
    letters = words.map { |word| word.split(//).uniq }.flatten
    letters.inject(Hash.new(0)) { |freq, letter| freq[letter] += 1; freq }
  end
  
puts find_hardest_word