(defrule r1
  (declare (salience 1))
  (factoid (name A))
  (factoid (name B))
  =>
  (assert(factoid (name E)))
)

(defrule rP1
  (declare (salience 1))
  (factoid (name X))
  (factoid (name A))
  (factoid (name B))
  =>
  (assert (product (name p1) (value 1)))
)
