require 'set'

class Keypad
  attr_reader :mode_keys, :code_length
  attr_accessor :key_history, :code_bank, :possible_codes, :duplicates

  def initialize(code_length = 4, mode_keys = [1, 2, 3])
    @key_history = []
    @code_bank = []
    @mode_keys = mode_keys
    @code_length = code_length
    @possible_codes = find_possible_codes
    @duplicates = 0
  end

  def find_possible_codes
    possible_codes = Set.new
    highest_code = '9' * code_length
    (highest_code.to_i + 1).times do |code|
      possible_codes << code.to_s.rjust(code_length,"0").split("").map(&:to_i)
    end

    possible_codes
  end

  def press(key)
    key_history << key
    check_code if key_history.length >= code_length && mode_keys.include?(key)
  end

  def check_code
    code = key_history.last(code_length + 1)
    code.pop
    self.duplicates += 1 if !possible_codes.include?(code)
    possible_codes.delete(code)
    if all_codes_entered?
      puts "All codes have been entered!"
      puts "You pressed #{key_history.length} keys and had #{duplicates} duplicates."
    end
  end

  def all_codes_entered?
    possible_codes.empty?
  end
end
