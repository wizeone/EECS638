; author: Dominic Pitts
; class: EECS 638 Expert Systems
; file. funct.CLP

(deffunction printCurrentState()
  ; prints out current state of each resource in global variables
  ; 1 represents in use
  ; 0 represent not in use
  (printout outputFile " " crlf)
  (printout outputFile "Current State: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10" crlf)
  (printout outputFile "Current State: " ?*p1* ", " ?*p2* ", " ?*p3* ", " ?*p4* ", " ?*p5* ", " ?*p6* ", " ?*p7* ", " ?*p8* ", " ?*p9* ", " ?*p10* crlf)
  (printout outputFile " " crlf)
)
