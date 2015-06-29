require_relative 'keypad.rb'

class KeypadTester
  attr_accessor :keypad

  def initialize(code_length = 4, mode_keys = [1, 2, 3])
    @keypad = Keypad.new(code_length, mode_keys)
  end

  def run
    greedy_algorithm
  end

  def greedy_algorithm
    keypad.possible_codes.each do |code|
      code.each do |key|
        keypad.press(key)
      end
      keypad.press(keypad.mode_keys[0])
    end
  end
end

KeypadTester.new.run
