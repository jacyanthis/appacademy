def bubble_sort(array)
  sorted = false
  while sorted == false
    sorted = true
    i = 0
    while i < array.length - 1
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        sorted = false
      end
      i += 1
    end
  end
  array
end

puts(bubble_sort([3,4,4,5,1,2,9,2]).to_s)