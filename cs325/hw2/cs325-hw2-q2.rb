#!/usr/bin/ruby

# Describe an O(log n) time algorithm to search a bitonic sequence of length n for a number k.

# some notes:
#  - ruby has integer division, other languages might need Math.round or equiv
#  - assuming this is asking for .contains() rather than .index_of()

def bitonic_search(input_arr, value)
  # find pivot point of bitonic array where it switches from ascending to descending
  midpoint = find_midpoint(input_arr)

  # search each "half" for the value
  left_result = sorted_search(input_arr, 0, midpoint, value, true)
  right_result = sorted_search(input_arr, midpoint+1, input_arr.size, value, false)

  if left_result > -1
    return left_result
  elsif right_result > -1
    return right_result
  else
    return -1
  end
end

def find_midpoint(input_arr, )

end

# search for value in a sorted array
def sorted_search(input_arr, search_min, search_max, value, ascending_sort)
  # base case -- search area is 1 or smaller
  if search_max - search_min <= 0
    return input_arr[search_min] == value ? search_min : -1
  end

  midpoint = (search_max + search_min) / 2

  case value <=> input_arr[midpoint]
  when 0 # value = pivot
    return midpoint
  when ascending_sort ? -1 : 1 # check first half
    return sorted_search(input_arr, search_min, midpoint-1, value, ascending_sort)
  when ascending_sort ? 1 : -1 # check second half
    return sorted_search(input_arr, midpoint+1, search_max, value, ascending_sort)
  else
    raise 'error comparing values'
  end
end

def test(arr, val)
  puts "Searching for #{val} in #{arr}
    Calculated: #{sorted_search(arr, 0, arr.size-1, val, true)}
    Actual:     #{arr.index(val)}"
end

test ('a'..'z').to_a, 'g'
test (0..20).to_a, 15
