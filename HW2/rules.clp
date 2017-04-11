(defrule R1
  (declare (salience 1))
  (fact (name A))
  (fact (name B))
  =>
  (assert (fact (name E)))
)

(defrule R2
  (declare (salience 2))
  (fact (name A))
  (fact (name C))
  =>
  (assert (fact (name F)))
)

(defrule R3
  (declare (salience 3))
  (not (fact (name A)))
  (fact (name B))
  =>
  (assert (fact (name D)))
)

(defrule R4
  (declare (salience 4))
  (not (fact (name A)))
  (not (fact (name B)))
  =>
  (assert (fact (name E)))
)

(defrule R5
  (declare (salience 5))
  (fact (name B))
  (fact (name C))
  =>
  (assert (fact (name F)))
)

(defrule R6
  (declare (salience 6))
  (fact (name D))
  (not (fact (name F)))
  =>
  (assert (fact (name H)))
)

(defrule R7
  (declare (salience 7))
  (fact (name D))
  (fact (name F))
  =>
  (assert (fact (name G)))
)

(defrule R8
  (declare (salience 8))
  (fact (name E))
  (fact (name F))
  =>
  (assert (fact (name H)))
)

(defrule R9
  (declare (salience 9))
  (fact (name E))
  (not (fact (name F)))
  =>
  (assert (fact (name G)))
)
