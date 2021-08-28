(de del-pt ()

  (let ((C Pt-C Reg-C
         B Pt-B Reg-B
         A Pt-A)
        (refs-2> *ptr))


    (cond

      ((isa '+Atom Pt-C)

        (make-str-x-a NIL Reg-C Pt-B Pt-C))

      ((isa '+Pair Pt-C)

        (if (lay-y?> Pt-C)
            (del-pair-y Pt-A Pt-B Pt-C Reg-C)
            (del-pair-x Pt-A Pt-B Pt-C Reg-C))))))



(de del-pair-x (Pt-A Pt-B Pt-C Reg-C)

  # con x cdr to x cdr

  (println 'del-pair-x)

  # handle con x cdr to y pair
  # must relink lines

  # x
  #
  # *
  # x
  #
  # y

  # Con B-C->CDR

  (let (CC (cdr (get Pt-C 'any))
        Pt-CC (if (pair CC)
                  (lup-pt @)
                  (get Pt-C 'b))
        Ln-Prv (get (c-lns> *ptr) 'line 'p))

    # if C has line and is X, mov to CC
    # if C has line and is Y, pop it and connect prv to nxt
    (when (get Pt-C 'line)
      (if (lay-x?> Pt-C)
          (mov-line Pt-C Pt-CC)
          (pop-line Pt-C)
          (con-line Ln-Prv Pt-CC))
      # cur line changes so pop cur line
      (lns> *ptr)
      # set new line to CC
      # ensures CC has 'line set
      (set-ln-n> *ptr Pt-CC))

    (if (= Reg-C 'a)
        (set> Pt-B (get Pt-CC 'any) Pt-CC)
        (con> Pt-B (get Pt-CC 'any) Pt-CC)))

  # pt to CC
  (pt> *ptr (get Pt-B 'any) Reg-C 'draw 'col)

  (del> Pt-C T NIL)

  (lay-*start)

  (top-ref> *ptr)
  (draw> *ptr))


(de del-pair-y (Pt-A Pt-B Pt-C Reg-C)

  # x
  #
  # *
  # y x/y

  # con x cdr to y car


  #   *
  # y y y
  #


  #   *
  # y y x
  #
  # con y car to y car

  (println 'del-pair-y)

  # handle y pair

  # Con B-C->CAR

  (let (CC (car (get Pt-C 'any))
        Pt-CC (if (pair CC)
                  (lup-pt @)
                  (get Pt-C 'a))
        Ln-Prv (get (c-lns> *ptr) 'line 'p))

    (lns> *ptr)
    (set-ln-n> *ptr Pt-CC)

    # if B is X, con line
    (when (lay-x?> Pt-B)
      # Con creating line for X pair
      (con-line Ln-Prv Pt-CC))

    (if (= Reg-C 'a)
        (set> Pt-B (get Pt-CC 'any) Pt-CC)
        (con> Pt-B (get Pt-CC 'any) Pt-CC)))

  # pt to CC
  (pt> *ptr (get Pt-B 'any) Reg-C 'draw 'col)

  (del> Pt-C NIL T)

  (lay-*start)

  (top-ref> *ptr)
  (draw> *ptr))
