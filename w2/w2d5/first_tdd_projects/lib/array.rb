class Array
  def my_uniq
    array = []
    self.each do |element|
      array << element unless array.include?(element)
    end

    array
  end

  def two_sum
    two_sums = []
    i = 0
    while i < (self.length - 1)
      j = i + 1
      while j < self.length
        two_sums << [i,j] if (self[i] + self[j] == 0)
        j+= 1
      end
      i += 1
    end
    two_sums
  end

  def median
    if self.length.odd?
        mid_point = (self.length - 1) / 2
        self[mid_point]
    else
      mid1 = (self.length / 2)
      mid2 = (self.length - 1 ) / 2
      (self[mid1] + self[mid2]) / 2
    end
  end

  def my_transpose
    transposed_arr = []
    self.length.times do
      transposed_arr << []
    end
    i = 0
    while i < self.length
     j = 0
     while j < self.length
       transposed_arr[j] << self[i][j]
       j += 1
     end
     i += 1
    end
    transposed_arr
  end


end
