; author: Dominic Pitts
; class: EECS 638 Expert Systems
; file. rules.CLP

; read input file and give access accordingly
(defrule getLine
  (declare (salience 4))

  ?factX <- (resRequest (name "X") (request no))
  ?factY <- (resRequest (name "Y") (request no))
  ?factZ <- (resRequest (name "Z") (request no))

  ?factFree <- (resRequest (name "Free") (request no))

  ?factEnd <- (endProgram (quit no))
  =>

  ; get line values
  (bind ?X (read inputFile))
  (bind ?Y (read inputFile))
  (bind ?Z (read inputFile))

  (printout outputFile "Input values: " ?X " " ?Y " " ?Z crlf)

  (if (and (= ?X -1) (= ?Y -1) (= ?Z -1))
    then
    (modify ?factEnd (quit yes))
    (printout outputFile "End of program." crlf)
  )
  ; based on input, grant access to correct resource
  ; priority X > Y > Z
  ;
  ; Checks values of inputs left to right granting access the moment
  ; it finds a 1, if all inputs are 0 a free access is granted
  (if (= ?X 1)
    then
    (modify ?factX (request yes)) ; X given access
  )
  (if (= ?Y 1)
    then
    (modify ?factY (request yes)) ; Y given access
  )
  (if (= ?Z 1)
    then
    (modify ?factZ (request yes)) ; Z given access
  )
  (if (and (= ?X 0) (= ?Y 0) (= ?Z 0))
    then
    (modify ?factFree (request yes)) ; no access given
  )
)

(defrule allowAccessX
  (declare (salience 3))
  ; request for X
  ?factXReq <- (resRequest (name "X") (request yes))
  ; X doesn't already have resource
  ?factX <- (reqNode (name "Request for product X") (resource no))
  ; resources A and B both have a resource
  ?factA <- (resNode (name "A") (resource1 yes))
  ?factB <- (resNode (name "B") (resource1 yes))
  ; p1 is free
  ?factp1 <- (prodNode (name "p1") (resource no))
  ; no other res currently accessing
  ?accessX <- (resAccess (name "X") (access no))
  ; dont need to store Y and Z so just Checks
  (resAccess (name "Y") (access no))
  (resAccess (name "Z") (access no))

  =>

  ; place resources from A and B into X and p1
  (modify ?factA (resource1 no))
  (modify ?factX (resource yes))
  (modify ?factB (resource1 no))
  (modify ?factp1 (resource yes))
  ;give access to X
  (modify ?accessX (access yes))
  ;change global p1 variable for state
  (bind ?*p1* 1)

  ;print actions
  (printout outputFile "Reallocating resources from Resources -A- and -B- to -Request for product X- and -p1" crlf)
  (printCurrentState)
)

(defrule allowAccessY
  (declare (salience 2))
  ; request for Y
  ?factYReq <- (resRequest (name "Y") (request yes))
  ; Y doesn't already have resource
  ?factY <- (reqNode (name "Request for product Y") (resource no))
  ; resources B and C both have a resource
  ?factB <- (resNode (name "B") (resource2 yes))
  ?factC <- (resNode (name "C") (resource1 yes))
  ; p5 is free
  ?factp5 <- (prodNode (name "p5") (resource no))
  ; no other res currently accessing
  ?accessY <- (resAccess (name "Y") (access no))
  ; dont need to store X and Z so just Checks
  (resAccess (name "X") (access no))
  (resAccess (name "Z") (access no))

  =>

  ; place resources from B and C into Y and p5
  (modify ?factB (resource2 no))
  (modify ?factY (resource yes))
  (modify ?factC (resource1 no))
  (modify ?factp5 (resource yes))
  ;give access to Y
  (modify ?accessY (access yes))
  ;change global p5 variable for state
  (bind ?*p5* 1)

  ;print actions
  (printout outputFile "Reallocating resources from Resources -B- and -C- to -Request for product -Y- and -p5-" crlf)
  (printCurrentState)
)

(defrule allowAccessZ
  (declare (salience 1))
  ; request for Z
  ?factZReq <- (resRequest (name "Z") (request yes))
  ; Z doesn't already have resource
  ?factZ <- (reqNode (name "Request for product Z") (resource no))
  ; resource C has resource2
  ?factC <- (resNode (name "C") (resource2 yes))
  ; p8 is free
  ?factp8 <- (prodNode (name "p8") (resource no))
  ; no other res currently accessing
  ?accessZ <- (resAccess (name "Z") (access no))
  ; dont need to store X and Y so just Checks
  (resAccess (name "X") (access no))
  (resAccess (name "Y") (access no))

  =>

  ; place resources from C into Z and p8
  (modify ?factZ (resource yes))
  (modify ?factC (resource2 no))
  (modify ?factp8 (resource yes))
  ;give access to Z
  (modify ?accessZ (access yes))
  ;change global p8 variable for state
  (bind ?*p8* 1)

  ;print actions
  (printout outputFile "Reallocating resources from Resource -C- to -Request for product -Z- and -p8-" crlf)
  (printCurrentState)
)

(defrule allFree
  (declare (salience 0))
  ?factFree <- (resRequest (name "Free") (request yes))

  =>

  (modify ?factFree (request no))

  ;print actions
  (printout outputFile "No request given access" crlf)
  (printCurrentState)
)

(defrule P1toP2
  (declare (salience 3))
  ;X is requested still, p1 is in use and p2 has no resources
  (reqNode (name "Request for product X") (resource yes))
  ?p1Res <- (prodNode (name "p1") (resource yes))
  ?p2Res <- (prodNode (name "p2") (resource no))
  ;Resources A and B still do not hold resources
  (resNode (name "A") (resource1 no))
  (resNode (name "B") (resource1 no))
  =>
  ;move from p1 to p2
  (modify ?p1Res (resource no))
  (modify ?p2Res (resource yes))

  ;bind global variables for state
  (bind ?*p1* 0)
  (bind ?*p2* 1)

  ;print actions
  (printout outputFile "Transitioned from p1 to p2" crlf)
  (printCurrentState)
)

(defrule P2toP3
  (declare (salience 3))
  ;X is requested still, p2 is in use and p3 has no resources
  (reqNode (name "Request for product X") (resource yes))
  ?p2Res <- (prodNode (name "p2") (resource yes))
  ?p3Res <- (prodNode (name "p3") (resource no))
  ;Resources A and B still do not hold resources
  (resNode (name "A") (resource1 no))
  (resNode (name "B") (resource1 no))
  =>
  ;move from p2 to p3
  (modify ?p2Res (resource no))
  (modify ?p3Res (resource yes))

  ;bind global variables for state
  (bind ?*p2* 0)
  (bind ?*p3* 1)

  ;print actions
  (printout outputFile "Transitioned from p2 to p3" crlf)
  (printCurrentState)
)

(defrule P3toP4
  (declare (salience 3))
  ;X is requested still, p3 is in use and p4 has no resources
  (reqNode (name "Request for product X") (resource yes))
  ?p3Res <- (prodNode (name "p3") (resource yes))
  ?p4Res <- (prodNode (name "p4") (resource no))
  ;Resources A and B still do not hold resources
  (resNode (name "A") (resource1 no))
  (resNode (name "B") (resource1 no))
  =>
  ;move from p3 to p4
  (modify ?p3Res (resource no))
  (modify ?p4Res (resource yes))

  ;bind global variables for state
  (bind ?*p3* 0)
  (bind ?*p4* 1)

  ;print actions
  (printout outputFile "Transitioned from p3 to p4" crlf)
  (printCurrentState)
)

(defrule P5toP6
  (declare (salience 2))
  ;Y is requested still, p5 is in use and p6 has no resources
  (reqNode (name "Request for product Y") (resource yes))
  ?p5Res <- (prodNode (name "p5") (resource yes))
  ?p6Res <- (prodNode (name "p6") (resource no))
  ;Resources B and C still do not hold resources
  (resNode (name "B") (resource2 no))
  (resNode (name "C") (resource1 no))
  =>
  ;move from p5 to p6
  (modify ?p5Res (resource no))
  (modify ?p6Res (resource yes))

  ;bind global variables for state
  (bind ?*p5* 0)
  (bind ?*p6* 1)

  ;print actions
  (printout outputFile "Transitioned from p5 to p6" crlf)
  (printCurrentState)
)

(defrule P6toP7
  (declare (salience 2))
  ;Y is requested still, p6 is in use and p7 has no resources
  (reqNode (name "Request for product Y") (resource yes))
  ?p6Res <- (prodNode (name "p6") (resource yes))
  ?p7Res <- (prodNode (name "p7") (resource no))
  ;Resources B and C still do not hold resources
  (resNode (name "B") (resource2 no))
  (resNode (name "C") (resource1 no))
  =>
  ;move from p6 to p7
  (modify ?p6Res (resource no))
  (modify ?p7Res (resource yes))

  ;bind global variables for state
  (bind ?*p6* 0)
  (bind ?*p7* 1)

  ;print actions
  (printout outputFile "Transitioned from p6 to p7" crlf)
  (printCurrentState)
)

(defrule P8toP9
  (declare (salience 1))
  ;Z is requested still, p8 is in use and p9 has no resources
  (reqNode (name "Request for product Z") (resource yes))
  ?p8Res <- (prodNode (name "p8") (resource yes))
  ?p9Res <- (prodNode (name "p9") (resource no))
  ;Resource C still does not hold resource2
  (resNode (name "C") (resource2 no))
  =>
  ;move from p8 to p9
  (modify ?p8Res (resource no))
  (modify ?p9Res (resource yes))

  ;bind global variables for state
  (bind ?*p8* 0)
  (bind ?*p9* 1)

  ;print actions
  (printout outputFile "Transitioned from p8 to p9" crlf)
  (printCurrentState)
)

(defrule P9toP10
  (declare (salience 1))
  ;Z is requested still, p9 is in use and p10 has no resources
  (reqNode (name "Request for product Z") (resource yes))
  ?p9Res <- (prodNode (name "p9") (resource yes))
  ?p10Res <- (prodNode (name "p10") (resource no))
  ;Resource C still does not hold resource2
  (resNode (name "C") (resource2 no))
  =>
  ;move from p9 to p10
  (modify ?p9Res (resource no))
  (modify ?p10Res (resource yes))

  ;bind global variables for state
  (bind ?*p9* 0)
  (bind ?*p10* 1)

  ;print actions
  (printout outputFile "Transitioned from p9 to p10" crlf)
  (printCurrentState)
)

(defrule productX
  (declare (salience 3))
  ; X node active
  ?reqX <- (reqNode (name "Request for product X") (resource yes))
  ; request for X active
  ?factX <- (resRequest (name "X") (request yes))
  ; X has access
  ?accessX <- (resAccess (name "X") (access yes))
  ; p4 active
  ?p4Res <- (prodNode (name "p4") (resource yes))
  ; Resources A and B resource 1 still taken
  ?resA <- (resNode (name "A") (resource1 no))
  ?resB <- (resNode (name "B") (resource1 no))
  =>
  ; release all resources
  (modify ?reqX (resource no))
  (modify ?factX (request no))
  (modify ?accessX (access no))
  (modify ?p4Res (resource no))
  (modify ?resA (resource1 yes))
  (modify ?resB (resource1 yes))

  ;bind global variables for state
  (bind ?*p4* 0)

  ;print actions
  (printout outputFile "p4 was reached. Product X is produced." crlf)
  (printCurrentState)
)

(defrule productY
  (declare (salience 2))
  ; Y node active
  ?reqY <- (reqNode (name "Request for product Y") (resource yes))
  ; request for Y active
  ?factY <- (resRequest (name "Y") (request yes))
  ; Y has access
  ?accessY <- (resAccess (name "Y") (access yes))
  ; p7 active
  ?p7Res <- (prodNode (name "p7") (resource yes))
  ; Resources B and C resource still taken
  ?resB <- (resNode (name "B") (resource2 no))
  ?resC <- (resNode (name "C") (resource1 no))
  =>
  ; release all resources
  (modify ?reqY (resource no))
  (modify ?factY (request no))
  (modify ?accessY (access no))
  (modify ?p7Res (resource no))
  (modify ?resB (resource2 yes))
  (modify ?resC (resource1 yes))

  ;bind global variables for state
  (bind ?*p7* 0)

  ;print actions
  (printout outputFile "p7 was reached. Product Y is produced." crlf)
  (printCurrentState)
)

(defrule productZ
  (declare (salience 1))
  ; Z node active
  ?reqZ <- (reqNode (name "Request for product Z") (resource yes))
  ; request for Z active
  ?factZ <- (resRequest (name "Z") (request yes))
  ; Z has access
  ?accessZ <- (resAccess (name "Z") (access yes))
  ; p10 active
  ?p10Res <- (prodNode (name "p10") (resource yes))
  ; Resource C resource still taken
  ?resC <- (resNode (name "C") (resource2 no))
  =>
  ; release all resources
  (modify ?reqZ (resource no))
  (modify ?factZ (request no))
  (modify ?accessZ (access no))
  (modify ?p10Res (resource no))
  (modify ?resC (resource2 yes))

  ;bind global variables for state
  (bind ?*p10* 0)

  ;print actions
  (printout outputFile "p10 was reached. Product Z is produced." crlf)
  (printCurrentState)
)
