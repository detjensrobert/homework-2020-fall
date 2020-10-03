#!/usr/bin/env ruby

#      A
#    /   \
#   B     C
#        / \
#       F   G
#
# Preorder:  A B C F G
# Postorder: G F C B A

# basic object/class with 3 basic values
class Node
  attr_accessor :value, :left, :right
  def initialize value
    @value = value
  end
end

# input: pre -- array of node values in preorder form
def reconstruct_tree(pre)
    unless pre.size & (pre.size + 1) == 0

  if pre.size == 1
    # base case: just a leaf, not a branch
    return Node.new pre[0]

  else
    # recursive case: split input and create branches
    n = Node.new pre.shift # first elem in pre is self's value

    # self value has been consumed from array, so split rest of array
    # into left and right sections to make sub-branches
    branch_len = pre.size / 2
    n.left = reconstruct_tree(pre.shift(branch_len))
    n.right = reconstruct_tree(pre.shift(branch_len))
    return n
  end
end

# Prints tree, but sideways b/c thats easier (/shrug)
def pretty_print(node, indent = 0)
  pretty_print(node.right, indent+4) if node.right
  puts " "*indent + node.value
  pretty_print(node.left, indent+4) if node.left
end

pretty_print reconstruct_tree %w(A B D E C F G) # 3 layer tree
puts '-'*20
pretty_print reconstruct_tree (1..15).to_a.map(&:to_s) # 4 layer tree (15 nodes)
