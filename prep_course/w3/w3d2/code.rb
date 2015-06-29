class Code
  COLORS = %w(red blue green yellow orange purple) 
  
  attr_reader :pegs
  
  def initialize(array)
    @pegs = array
  end
  
  def [](pos)
    @pegs[pos]
  end

  def []=(pos, peg)
    @pegs[pos] = peg
  end
  
  def self.random
    Code.new(COLORS.sample(4))
  end
  
  def self.parse(input)
    array = []
    (0..3).each do |idx|
      COLORS.each { |color| array << color if color[0] == input[idx] }
    end
    Code.new(array)
  end
  
  def exact_matches(player_code)
    secret_code = self.deep_dup
    exact_matches = 0
    
    (0..3).each do |idx|
      if player_code[idx] == secret_code[idx]
        exact_matches += 1 
        secret_code[idx] = nil
        player_code[idx] = nil
      end
    end
    
    [secret_code, player_code, exact_matches]
  end
  
  def near_matches(player_code)
    near_matches = 0
    
    (0..3).each do |idx1|
      next if player_code[idx1] == nil
      (0..3).each do |idx2|
        if idx1 != idx2 && player_code[idx1] == self[idx2]
          near_matches += 1
          player_code[idx1] = nil
        end
      end
    end
    
    near_matches
  end
  
  def matches(player_code)
    exact_matches = exact_matches(player_code)
    secret_code, player_code, num_exact_matches = exact_matches[0], exact_matches[1], exact_matches[2]
    num_near_matches = secret_code.near_matches(player_code)
    [num_exact_matches, num_near_matches]
  end
  
  def deep_dup
    array = []
    
    self.pegs.each do |peg|
      array << peg
    end
    
    Code.new(array)
  end

end