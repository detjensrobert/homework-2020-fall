#!/usr/bin/ruby

def find_deleted_index (original, modified, start_i, end_i)

  if end_i-start_i < 1
    # puts "Ending at #{start_i} to #{end_i}"
    return start_i
  end

  mid_i = (start_i + end_i) / 2

  # puts "Searching #{start_i} to #{end_i} (mid #{mid_i})"

  # if midpoint is the same, deleted elem is in last half
  if original[mid_i] == modified[mid_i]
    find_deleted_index(original, modified, mid_i+1, end_i)
  else
    find_deleted_index(original, modified, start_i, mid_i)
  end
end

original_array = ('a'..'z').to_a
(0..original_array.size).to_a.each do |index|
  deleted_array = original_array.dup.tap { |a| a.delete_at(index) }

  deleted_index = find_deleted_index(original_array, deleted_array, 0, original_array.size)
  # deleted_index += 1 # Prof wants 1-indexed :(((

  raise "Deleted index: #{deleted_index}, should be #{index}" if deleted_index != index
end

puts "All cases passed"
