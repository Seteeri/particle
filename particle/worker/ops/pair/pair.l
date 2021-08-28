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

    Gen new pair
    Make Y layout
    Set pair car to old pair
    Attach prv to new pair
    Pt to same pair

      [X] [X]
       a   b

      [Y] [X] NIL
           c

      NIL


      [X]
       a

      [Y] [X]
           b

          [Y] [X] NIL
               c

          NIL

      NIL

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
    (if Pt-Ln-N
        (con-line Pt-C Pt-Ln-N)
        (when (= Ln Pt-C) (lns> *ptr)))

    # Draw main tree, then ptr

    (lay-*start)

    (lns> *ptr Pt-Cons)
    (lns> *ptr Pt-C)

    # Still pt to C
    (with *ptr
      (=: any Cons)
      (=: reg 'a))

    (top-ref> *ptr)
    (draw> *ptr)))


(de make-pair-b-pair-old (Pt-B Pt-C)

  (println 'make-pair-b-pair)

  (let (C (get Pt-C 'any)
        Cons (cons)
        Pt-Cons (gen-point Cons 'x NIL T)
        Pt-Cdr (get Pt-Cons 'b)
        Ln (c-lns> *ptr))

    (set-lay> Pt-Cons 'y)
    (put Pt-Cons 'line (new '(+Line) Ln Pt-Cdr))
    (put Pt-Cdr 'line (new '(+Line) Pt-Cons NIL))

    (con> Pt-B Cons Pt-Cons)
    (set> Pt-Cons C Pt-C 'del)

    # Still pt to og pair
    # must upd any
    (with *ptr
      (=: any Cons)
      (=: reg 'a))

    (lay-*start)

    # push new, then C
    # pop old as needed
    (when (= Ln Pt-C) (lns> *ptr))
    (lns> *ptr Pt-Cons)
    (lns> *ptr Pt-C)

    (top-ref> *ptr)
    (draw> *ptr)))


(de make-pair-a-pair (Pt-B Pt-C)

  #{

    Replace pair with pair.car=pair

    Later output X-Pair

    Case 1:

        [X]
         .

               *
        [Y1]  [X1]  .
               .

        [X]  .
         .

      -->

        [X]
         .

                     *
        [Y1]  [Y2]  [X1]  .
                     .
               .

        [X]  .
         .

    Case 2:


        [X]
         .

               *
        [Y1]  [Y2]  .
               .

        [X]  .
         .

      -->


        [X]
         .

               *
        [Y1]  [Y3]  [Y2]  .
                     .
               .

        [X]  .
         .

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

    # Still pt to og pair
    # must upd any
    (with *ptr
      (=: any Cons)
      (=: reg 'a))

    (lay-*start)

    # Pt to new cons so pop old line, push cons
    (lns> *ptr)
    (lns> *ptr Pt-Cons)
    (lns> *ptr Pt-C)

    (top-ref> *ptr)
    (draw> *ptr)))
