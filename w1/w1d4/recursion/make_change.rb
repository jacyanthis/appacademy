def make_change(target, coins)
  return nil if target < 0
  return [] if target == 0
  choices = []
  coins.each do |coin|
    choice = make_change(target - coin, coins)
    choices << [coin] + choice if choice
  end
  choices.min_by { |choice| choice.length }
end
