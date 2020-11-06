---
header-includes:
  - \usepackage{qtree}
---

# CS 325 Midterm

## Robert Detjens

---

## 1. Mark True or False for each of the following statements.

a. True

b. True

c. False

d. True

e. True

f. True

## 2. What is the running time of this sorting algorithm? Write the recursion for the running time, and use the recursion tree method to solve it.

$T(n) = 4T(n/4) + O(n)$

$$
\Tree [.n
        [.n/4 . . . . ]
        [.n/4 . . . . ]
        [.n/4 . . . . ]
        [.n/4 . . . . ]
      ]
$$

Level 1: $n$

Level 2: $4 * n/4 = n$

Level 2: $16 * n/16 = n$

$$\text{Total runtime: } \sum_{i=1}^{\log{n}} n = O(n\log{n})$$

$\pagebreak$

## 3. Do you think this maximum finder is faster than the regular iterative one? What is its running time? Write the recursion for the running time, and use the recursion tree method to solve it.

At first, I thought the recursive finder would not be faster than the iterative one as each element still needs to be compared at least once, which will result in $O(n)$ runtime regardless of approach. However, after calculating the runtime, this recursive alg is indeed faster.

$T(n) = 2T(n/2) + O(1)$

$$
\Tree [.1
        [.1 1 1 ]
        [.1 1 1 ]
      ]
$$

Level 1: $1$

Level 2: $2 * 1 = 2$

Level 2: $4 * 1 = 4$

$$\text{Total runtime: } \sum_{i=1}^{\log{n}} 2^i = O(2^{\log{n}})$$

## 4. Design and analyze a fast algorithm to find the index of deleted elements given 2 arrays within $O(n\log{n})$ time.

A recursive solution can intelligently check which half of an array has the deleted element by comparing a value from the same index from both arrays. If the value does not match, the deleted element is from the first half, and it they are same the deleted element is in the last half. An algorithm to check two arrays to find a deleted element can use this property to only check the halves it needs to.

An implementation of such an algorithm in Ruby:

```rb
def find_deleted_index (original, modified, start_i, end_i)
  # base case: we've found where the deleted element should have been
  if end_i - start_i < 1
    return start_i
  end

  mid_i = (start_i + end_i) / 2
  # if midpoint is the same, deleted elem is in last half
  if original[mid_i] == modified[mid_i]
    find_deleted_index(original, modified, mid_i+1, end_i)
  else # if they aren't, it was deleted in the first half
    find_deleted_index(original, modified, start_i, mid_i)
  end
end
```

The recursive runtime of this algorithm is $T(n) = T(n/2) + O(1)$ as only one branch of the tree is explored.

$$\text{Total runtime: } \sum_{i=1}^{\log{n}} 1 = O(\log{n})$$

$\pagebreak$

## 5. Ternary Strings

$P(n)$ = the number of strings of length $n$ with alphabet [012] that do not contain the substring `00`.

### a. Design a recursive algorithm to compute $P(n)$. Justify the correctness of your algorithm

*I don't know.*

### b. Turn the recursive algorithm of 5.a into dynamic programming.

*I don't know.*

### c. What is the running time of your dynamic programming?

*I don't know.*

## 6. Chessboard

### a. Describe an efficient algorithm to compute the maximum possible score for a game of White Squares, given the $n*n$ array of values as input.

Similar to the Vankin's Mile problem, this can be solved in an efficient manner by memoisation / dynamic programming. By iterating backwards from the bottom right corner and recording the maximum possible score for each square, each square can refer to the already-calculated scores of its lower- and right-adjacent neighbors to calculate its best score.

An implementation of such an algorithm in pseudocode:

```rb
def white_squares_score (board) {
  scores = new matrix of same size as board

  # iterate backwards
  for (r = board.size-1; r >= 0; r--) {
    for (c = row.size-1; c >= 0; c--)
      right_score = board[r][c]
      down_score = board[r][c]
      if (board[r][c] has right neighbor) { right_score += board[r][c+1] }
      if (board[r][c] has down neighbor) { down_score += board[r+1][c] }

      scores[r][c] = max(right_score, down_score)
    }
  }

  return scores[0][0] # top left corner, starting position
}
```

### b. What is the running time of your algorithm?

The runtime of this algorithm would be $O(n^2)$ as there are two nested loops needed to traverse the entire board matrix. Each element is visited once.
