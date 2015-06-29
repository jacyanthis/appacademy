class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_map(&prc)
    new_array = []
    self.my_each { |el| new_array << prc.call(el) }
    new_array
  end

  def my_select(&prc)
    new_array = []
    self.my_each { |el| new_array << el if prc.call(el) }
    new_array
  end

  def my_inject(&prc)
    accumulator = self.first
    self.drop(1).my_each { |el| accumulator = prc.call(accumulator, el) }
    accumulator
  end

  def my_sort!(&prc)
    sorted = false

    until sorted
      sorted = true
      (self.length-1).times do |i|
        if prc.call(self[i], self[i+1]) == 1
          self[i], self[i+1] = self[i+1], self[i]
          sorted = false
        end
      end
    end

    self
  end

  def my_sort(&prc)
    copy = self.dup
    copy.my_sort!(&prc)
  end

end
