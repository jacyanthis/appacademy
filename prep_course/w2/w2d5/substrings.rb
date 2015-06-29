$words = []
File.foreach("dictionary.txt") do |line|
  $words << line.chomp
end

def substrings(string)
  substrings = []
  i = 0
  while i < string.length
    j = i
    while j < string.length
      substring = string.slice(i..j)
      if !substrings.include?(substring) && $words.include?(substring)
        substrings << substring
      end
      j += 1
    end
    i += 1
  end
  substrings
end

puts(substrings("banana").to_s)