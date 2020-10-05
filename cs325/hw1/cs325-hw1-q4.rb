#!/usr/bin/env ruby

# basic object/class with 3 basic values
class Node
  attr_accessor :left, :right, :value
  def initialize(value)
    @value = value
  end
end

def reconstruct_tree(pre, post)
  if pre.size == 1
    # base case: just a leaf, not a branch
    return Node.new pre[0]
  else
    # recursive case
    n = Node.new pre[0] # root val is first in pre

    # next val in pre is the left root, find that in post
    left_root_index = post.index(pre[1])

    # everything up to the left root in post is the left branch
    left_pre = pre[1..left_root_index+1] # shifted by one b/c root value is first elem
    left_post = post[0..left_root_index]
    n.left = reconstruct_tree(left_pre, left_post)

    # everything after the left root is the right branch
    right_pre = pre[left_root_index+2..-1]
    right_post = post[left_root_index+1..-2] # shifted by one b/c root value is last elem
    n.right = reconstruct_tree(right_pre, right_post)

    return n
  end
end

# Prints tree, but rotated 90* b/c thats easier to do
def pretty_print(node, indent=0, branch_char=' ')
  pretty_print(node.right, indent+3, '/-') if node.right
  puts ' '*indent + branch_char + node.value
  pretty_print(node.left, indent+3, '\\-') if node.left
end

puts 'Small tree:'
#      A
#    /   \
#   B     C
#        / \
#       F   G
pre  = %w(A B C F G)
post = %w(B F G C A)
pretty_print reconstruct_tree(pre, post)

puts 'Large tree:'
#         1
#      /     \
#     2       3
#    / \     /  \
#   4   5   6    7
#  / \          / \
# 8   9       14  15
pre  = %w(1 2 4 8 9 5 3 6 7 14 15)
post = %w(8 9 4 5 2 6 14 15 7 3 1)
pretty_print reconstruct_tree(pre, post)
