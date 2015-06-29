class PolyTreeNode
  attr_accessor :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    parent.children.delete(self) if parent
    @parent = new_parent
    parent.children << self if parent && !parent.children.include?(self)
  end

  def add_child(new_child)
    if new_child
      new_child.parent = self
    end
  end

  def remove_child(child)
    raise "Not a child" unless children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child|
      target_node = child.dfs(target_value)
      return target_node if target_node
    end
    nil
  end

  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    nil
  end
end
