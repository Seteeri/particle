(de make-pair-xb-x (Pt-B Pt-C) (make-pair-b-pair Pt-B Pt-C))
(de make-pair-xb-y (Pt-B Pt-C) (make-pair-b-pair Pt-B Pt-C))

(de make-pair-ya-x (Pt-B Pt-C) (make-pair-a-pair Pt-B Pt-C))
(de make-pair-yb-x (Pt-B Pt-C) (make-pair-b-pair Pt-B Pt-C))

(de make-pair-ya-y (Pt-B Pt-C) (make-pair-a-pair Pt-B Pt-C))
(de make-pair-yb-y (Pt-B Pt-C) (make-pair-b-pair Pt-B Pt-C))


(de make-pair-b-pair (Pt-B Pt-C)
  #{

    Cons pair

       *               *
    (a b (c d)) -> (a (b (c d)))


    Special Cases:

        *
      x x

      y x

      x



      x

        *
      y x

        y x

        x

      x

      ############

      x x x

      *
      y x

      x



      x x x

        *
      y y x

        x

      x

  }#

  (println 'make-pair-b-pair)

  (let (C (get Pt-C 'any)
        Cons (cons)
        Pt-Cons (gen-point Cons 'x NIL T)
        Pt-Cdr (get Pt-Cons 'b)
        Ln (c-lns> *ptr)
        Pt-Ln-N (get Ln 'line 'n))

    (set-lay> Pt-Cons 'y)

    (put Ln 'line 'n Pt-Cons)

    (put Pt-Cons 'line (new '(+Line) Ln Pt-Cdr))
    (put Pt-Cdr 'line (new '(+Line) Pt-Cons NIL))

    (con> Pt-B Cons Pt-Cons)

    (set> Pt-Cons C Pt-C 'del) # del car

    # if C-cdr has line, must reconnect line
    (when Pt-Ln-N
      (con-line Pt-C Pt-Ln-N))

    # Draw main tree, then ptr

    (lay-*start)

    # only X->X does not pop
    # since newline appended to cur
    (unless (and (lay-x?> Pt-B)
                 (lay-x?> Pt-C))
      (lns> *ptr))
    (lns> *ptr Pt-Cons)
    (lns> *ptr Pt-C)

    # Still pt to C
    (with *ptr
      (=: any Cons)
      (=: reg 'a))

    (top-ref> *ptr)
    (draw> *ptr)))


(de make-pair-a-pair (Pt-B Pt-C)

  #{

  }#

  (println 'make-pair-a-pair)

  (let (C (get Pt-C 'any)
        Cons (cons)
        Pt-Cons (gen-point Cons 'x NIL T)
        Pt-Cdr (get Pt-Cons 'b))

    (set-lay> Pt-Cons 'y)

    # no p ln since this always car of y pair

    (put Pt-Cons 'line (new '(+Line) NIL Pt-Cdr))
    (put Pt-Cdr 'line (new '(+Line) Pt-Cons NIL))

    (set> Pt-B Cons Pt-Cons)

    (set> Pt-Cons C Pt-C 'del)

    (lay-*start)

    # Pt to new cons so pop old line, push cons
    (lns> *ptr)
    (lns> *ptr Pt-Cons)
    (lns> *ptr Pt-C)

    # Still pt to og pair
    # must upd any
    (with *ptr
      (=: any Cons)
      (=: reg 'a))

    (top-ref> *ptr)
    (draw> *ptr)))
