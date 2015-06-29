#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.

def sum_recur(array)
  return 0 if array.empty?
  array.first + sum_recur(array.drop(1))
end


#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
  return true if array.first == target
  return false if array.empty?
  includes?(array.drop(1), target)
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?
  if array.first == target
    1 + num_occur(array.drop(1), target)
  else
    num_occur(array.drop(1), target)
  end
end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length < 2
  return true if array[0] + array[1] == 12
  add_to_twelve?(array.drop(1))
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
  return true if array.length < 2
  return false if array[0] > array[1]
  sorted?(array.drop(1))
end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)

# def reverse(number, front_zeros = 0)
#   puts "reversing: #{number}"
#   if number % 10 == 0
#     reverse_zero(number, front_zeros)
#   else
#     reverse_non_zero(number, front_zeros)
#   end
# end

def reverse(number)
  return number if number < 10
  back_zeros = find_back_zeros(number / 10)
  new_number = number / (10 ** (1 + back_zeros))
  "#{number % 10}#{"0" * back_zeros}#{reverse(new_number)}".to_i
end

def find_back_zeros(number)
  puts "finding the back zeros of #{number}"
  return 0 if number % 10 > 0
  1 + find_back_zeros(number / 10)
end
