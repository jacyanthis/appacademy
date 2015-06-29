def range(start, stop)
  return [] if start > stop
  [start] + range(start + 1, stop)
end

def sum_recursive(array)
  return 0 if array.length == 0
  array.first + sum_recursive(array.drop(1))
end

def sum_iterative(array)
  array.inject { |sum, num| sum + num }
end

def pow_1(base, exp)
  return 1 if exp == 0
  base * pow_1(base, exp - 1)
end

def pow_2(base, exp)
  return 1 if exp == 0
  return base if exp == 1
  if exp.even?
    root = pow_2(base, exp / 2)
    root * root
  else
    root = pow_2(base, (exp - 1) / 2)
    base * root * root
  end
end

class Array
  def deep_dup
    self.map do |e|
      if e.is_a?(Array)
        e.deep_dup
      else
        e.frozen? ? e : e.dup
      end
    end
  end
end

def fib(n)
  return [1, 1] if n == 2
  return [1] if n == 1
  return [] if n == 0
  previous_fib = fib(n - 1)
  previous_fib << previous_fib[-1] + previous_fib[-2]
end

def bsearch(array, target)
  midpoint_idx = array.length / 2
  midpoint = array[midpoint_idx]

  return nil if array.length == 0
  return midpoint_idx if midpoint == target
  if target > midpoint
    recursive_output = bsearch(array[(midpoint_idx + 1)..-1], target)
    return nil if recursive_output.nil?
    midpoint_idx + 1 + recursive_output
  else
    bsearch(array[0...midpoint_idx], target)
  end
end
