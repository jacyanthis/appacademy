
def subsets(array)
  return [[]] if array.empty?

  previous_subsets = subsets(array[0..-2])
  previous_subsets + previous_subsets.map { |s| s + [array.last] }
end
