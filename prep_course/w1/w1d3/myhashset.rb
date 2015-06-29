class MyHashSet
    
  attr_accessor :store
    
  def initialize
      @store = {}
  end
  
  def insert(el)
      store[el] = true
  end
  
  def include?(el)
      if store[el] == nil
          false
      else
          true
      end
  end
  
  def delete(el)
      if self.include?(el)
          delete = true
      else
          delete = false
      end
      store.delete(el)
      delete
  end
  
  def to_a
      store.keys
  end
  
  def union(set2)
    union = MyHashSet.new
    self.to_a.each { |el| new_set.insert(el) }
    set2.to_a.each { |el| new_set.insert(el) }
    union
  end

  def intersect(set2)
    intersect = MyHashSet.new
    self.to_a.each do |el|
      if set2.include?(el)
        intersect.insert(el)
      end
    end
    intersect
  end

  def minus(set2)
    minus = MyHashSet.new
    self.to_a.each do |el|
      if !(set2.include?(el))
        minus.insert(el)
      end
    end
    minus
  end
    
end

test = MyHashSet.new
test.insert("a")
puts(test)