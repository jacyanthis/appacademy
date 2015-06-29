class RPNCalculator
    
  attr_accessor :array
    
  def initialize
    @array = []
  end
  
  def push(element)
    array << element
  end
  
  def empty_calculator
    if array.length == 0
      raise "calculator is empty"
    elsif array.length == 1
      raise "calculator has only one number"
    end
  end
    
  def plus
    empty_calculator
    array[-2..-1] = array[-2] + array[-1]
  end
  
  def minus
    empty_calculator
    array[-2..-1] = array[-2] - array[-1]
  end
  
  def times
    empty_calculator
    array[-2..-1] = array[-2] * array[-1]
  end
  
  def divide
    empty_calculator
    array[-2..-1] = array[-2].to_f / array[-1]
  end
  
  def value
    array[-1]
  end
  
  def tokens(string)
    array2 = string.split(" ")
    array2.map do |element|
      if /^\d+$/.match(element) == nil
        element.to_sym
      else
        element.to_i
      end
    end
  end
  
  def evaluate(string)
    array2 = tokens(string)
    
    array2.each do |element|
      if element.is_a?(Fixnum)
        self.push(element)
      elsif element == :+
        self.plus
      elsif element == :-
        self.minus
      elsif element == :*
        self.times
      elsif element == :/
        self.divide
      end
    end
      self.value
  end

end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    user_input = ""
    finished = false
    while finished == false
      line = gets
      if line == "\n"
        finished = true
        break
      else
        user_input << " " << line.chomp
      end
    end
    puts(RPNCalculator.new.evaluate(user_input))
  else
    contents = File.read(ARGV[0])
    puts(RPNCalculator.new.evaluate(contents))
  end
end
