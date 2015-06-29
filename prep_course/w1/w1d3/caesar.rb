def caesar(str, shift)
  words = str.split(" ")
  i = 0
  while i < words.length
    j = 0
    while j < words[i].length
      code = words[i][j].ord - "a".ord
      new_code = (code + shift) % 26
      words[i][j] = ("a".ord + new_code).chr
      j += 1
    end
    i += 1
  end
  return words.join(" ")
end