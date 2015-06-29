def merge_sort(array)
  return array if array.length < 2
  midpoint = array.length/2
  left, right = array[0...midpoint], array[midpoint..-1]

  merge_helper(merge_sort(left), merge_sort(right))
end

def merge_helper(left, right)
  return left if right.length == 0
  return right if left.length == 0
  
  if left[0] < right[0]
    [left.shift] + merge_helper(left, right)
  else
    [right.shift] + merge_helper(left, right)
  end
end
