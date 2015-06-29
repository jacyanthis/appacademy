def factors(num)
  i = 1
  factors = []
  while i <= num
    if num % i == 0
      factors << i
    end
    i += 1
  end
  factors
end

puts(factors(12))