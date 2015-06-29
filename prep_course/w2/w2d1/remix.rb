def remix(array)
    result = []
    array.length.times { result << [] }
    array.shuffle.each_with_index { |pair, idx| result[idx] << pair[0] }
    array.shuffle.each_with_index { |pair, idx| result[idx] << pair[1] }
    result
end

puts(remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
]))