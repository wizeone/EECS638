; author: Dominic Pitts
; class: EECS 638 Expert Systems
; file. facts.CLP

;base templates
(deftemplate reqNode
  (slot name)
  (slot resource)
)

(deftemplate resNode
  (slot name)
  (slot resource1)
  (slot resource2)
)

(deftemplate prodNode
  (slot name)
  (slot resource)
)

;gives access to highest priority
(deftemplate resAccess
  (slot name)
  (slot access)
)

;chooses request using input
(deftemplate resRequest
  (slot name)
  (slot request)
)

;ends program at -1 -1 -1 input
(deftemplate endProgram
  (slot quit)
)

; global variables
(defglobal
  ?*p1* = 0
  ?*p2* = 0
  ?*p3* = 0
  ?*p4* = 0
  ?*p5* = 0
  ?*p6* = 0
  ?*p7* = 0
  ?*p8* = 0
  ?*p9* = 0
  ?*p10* = 0
)

;facts
(deffacts onStartUp
  (prodNode (name "p1") (resource no))
  (prodNode (name "p2") (resource no))
  (prodNode (name "p3") (resource no))
  (prodNode (name "p4") (resource no))
  (prodNode (name "p5") (resource no))
  (prodNode (name "p6") (resource no))
  (prodNode (name "p7") (resource no))
  (prodNode (name "p8") (resource no))
  (prodNode (name "p9") (resource no))
  (prodNode (name "p10") (resource no))
  (resNode (name "A") (resource1 yes) (resource2 yes))
  (resNode (name "B") (resource1 yes) (resource2 yes))
  (resNode (name "C") (resource1 yes) (resource2 yes))
  (reqNode (name "Request for product X") (resource no))
  (reqNode (name "Request for product Y") (resource no))
  (reqNode (name "Request for product Z") (resource no))
  (resRequest (name "Free") (request no))
  (resRequest (name "X") (request no))
  (resRequest (name "Y") (request no))
  (resRequest (name "Z") (request no))
  (resAccess (name "X") (access no))
  (resAccess (name "Y") (access no))
  (resAccess (name "Z") (access no))
  (endProgram (quit no))
)
