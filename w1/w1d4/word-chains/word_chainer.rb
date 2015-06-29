require 'set'
require 'byebug'

class WordChainer
  attr_accessor :current_words, :all_seen_words

  def initialize(dictionary_filename)
    @dictionary = get_dictionary(dictionary_filename)
  end

  def get_dictionary(filename)
    Set.new(File.readlines(filename).map(&:chomp))
  end

  def adjacent_words(target_word)
    @dictionary.select { |word| adjacent?(word, target_word) }
  end

  def adjacent?(word_a, word_b)
    word_a.length == word_b.length &&
    one_letter_off?(word_a, word_b)
  end

  def one_letter_off?(word_a, word_b)
    differences = 0
    # word_a_array = word_a.split("")
    word_a.length.times do |index|
      differences += 1 if word_b[index] != word_a[index]
      return false if differences > 1
    end
    differences == 1
  end

  def run(source, target)
    @current_words = {source => nil}
    @all_seen_words = {source => nil}
    until current_words.empty?
      self.current_words = explore_current_words(target)
    end

    build_path(target)
  end

  def explore_current_words(target)
    new_current_words = {}

    # debugger

    current_words.keys.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        unless all_seen_words.include?(adjacent_word)
          new_current_words[adjacent_word] = current_word
          self.all_seen_words[adjacent_word] = current_word
          return [] if adjacent_word == target
        end
      end
    end

    p new_current_words

    new_current_words
  end

  def build_path(target)
    return [target] if all_seen_words[target].nil?
    path = []
    all_seen_words.each do |key, value|
      if key == target
        path = [key] + build_path(value)
      end
    end

    path
  end

end
