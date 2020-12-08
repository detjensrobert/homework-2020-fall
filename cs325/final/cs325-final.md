# CS 325 Final

## Robert Detjens

---

## 1. For each of the following classes of graphs, determine the running time of this algorithm in terms of the number of vertices $V$ and the number of edges $E$.

```py
def DFS(s):
  put s into stack
  while stack is not empty:
    v = stack.pop()
    for (v, w) in E:
      stack.push(w)
```

#### a. $G$ is a general undirected graph.

*Infinite*

#### b. $G$ is an undirected tree.

$O(E)$

#### c. $G$ is a connected directed graph with NO directed or undirected cycles.

$O(E)$

#### d. $G$ is a directed acyclic graph.

$O(E)$

#### e. $G$ is a general directed graph.

*Inifinite*

---

## 2. For the following figure:

#### a. Mark all edges that are in the MST of $G$ for all choices of the unknown edge weights.

![](https://i.imgur.com/b0UePWZ.png){ height=100px }

Edge 5 will always be in the MST.

#### b. Mark all edges that are not in the MST of $G$ for all choices of the unknown edge weights.

![](https://i.imgur.com/OIFM23e.png){ height=100px }

Edge 9 will never be in the MST.

---

## 3. For each of the following figures, state which (if any) MST algorithms could have possibly chosen the highlighted edges.

#### a.

Prim/Jarnik

#### b.

Kruskal, Boruvka

#### c.

Boruvka

#### d.

*None*

---

## 4. Let $G = (V, E)$ be a simple graph with $n > 10$ vertices. Suppose the weight of every edge of $G$ is one.

#### a. What is the weight of a minimum spanning tree of $G$?

$n-1$

#### b. Suppose we change the weight of two edges of $G$ to $1/2$. What is the weight of the minimum spanning tree of $G$?

$n-2$

#### c. Suppose we change the weight of five edges of $G$ to $1/2$. What is the minimum and maximum possible weights for the the minimum spanning tree of $G$?

min: $n-3.5$ max: $n-2$

---

## 5. For each of the following statements, respond *True*, *False*, or *Unknown*.

#### a. P = NP.

*Unknown*

#### b. If P $\ne$ NP, then the satisfiability problem (SAT) cannot be solved in polynomial time.

*True*

#### c. If a problem is NP-complete, then it is NP-hard.

*True*

#### d. If there is a polynomial time reduction from the 3-satisfiability problem (3SAT) to problem $X$, then $X$ is NP-hard.

*True*

#### e. If there is a polynomial time reduction from problem $X$ to the 3-satisfiability problem (3SAT), then $X$ is not in P.

*False*

#### f. No problem in NP can be solved in polynomial time.

*False*

#### g. If there is a polynomial time algorithm to solve problem $A$, then $A$ is in P.

*True*

#### h. If there is a polynomial time algorithm to solve problem $A$, then $A$ is in NP.

*Unknown*

---

$\pagebreak$

## 6. Recall that Dijsktra’s algorithm works in polynomial time assuming all edges have positive weight.

### a. Describe and analyze an algorithm to find shortest path from $s$ to $t$ in a directed graph $G$ that has exactly one edge with negative weights (all other edges have positive weights).

To use Dijsktra’s, the graph needs to be converted to all positive edges. This can be done by increasing all edge weights by some constant $n$ where the weight of the negative edge $+ n > 0$. Once that is done, all edges will be positive and Dijsktra’s can be performed on the updated graph.

The reduction/transformation of the graph is linear, as the negative edge's value needs to be found ($O(\log n)$ - sub-linear time) and all edges need to be increased by $n$ ($O(E)$ - linear time). The total runtime of this algorithm is $O_{transformation}(linear) + O_{Dijsktra’s}(polynomial) = O_{total}(polynomial)$

### b. Describe and analyze an algorithm to find shortest path from $s$ to $t$ in a directed graph $G$ that has exactly two edges with negative weights (all other edges have positive weights).

To use Dijsktra’s, the graph needs to be converted to all positive edges. This can be done by increasing all edge weights by some constant $n$ where the weight of the more negative edge $+ n > 0$. Once that is done, all edges will be positive and Dijsktra’s can be performed on the updated graph.

The reduction/transformation of the graph is linear, as the more negative edge's value needs to be found ($O(\log n)$ - sub-linear time) and all edges need to be increased by $n$ ($O(E)$ - linear time). The total runtime of this algorithm is $O_{transformation}(linear) + O_{Dijsktra’s}(polynomial) = O_{total}(polynomial)$

---

## 7. Prove that the Almost Independent Subset of an undirected graph is NP-Complete.

*I don't know. :(*
