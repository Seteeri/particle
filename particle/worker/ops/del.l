#{

  Del: Repl cur with NIL/cdr

  Case 1:

    * On X/Y car/cdr atom: repl cur with NIL

         *
    [Y]  .

     .

    OR

    [X]  [X]  .
     .    *


  Case 2:

    * On X cdr pair: repl cur with cdr

          *
    [X]  [X]  .
     .    .

    ->

         *
    [X]  .
    .



  Case 3:

    * On X pair with Y cdr: repl cur with cdr

      [X]
       .

       *
      [Y]  [Y] .
            .

       c

       ->

      [X]
       .

       *
       c

      - Car promo: bsp car
      - Cdr promo: del pair
        - Consistent with X del


  Case 4:

    * On Y car pair: repl cur with car

          *
    [Y]  [Y]  .
          .
    .

    ->

     *
    [Y]  .
    .

}#


(de del-pt ()

  (cond

    ((a-atom?> *ptr)
     (make-str-x-a NIL 'a))

    ((b-atom?> *ptr)
     (make-str-x-a NIL 'b))

    ((or (a-pair?> *ptr)
         (b-pair?> *ptr))

     (let Pt (del-pair)
      (lay-*start)
      (top> Pt)
      (draw> *ptr)))))


(de del-pair ()

  (let ((C Pt-C Reg-C
         B Pt-B) (refs-1> *ptr)
        Cdr (cdr C)
        Atom-Cdr (atom Cdr)
        Pt-Cdr (if Atom-Cdr
                   (get Pt-C 'b)
                   (lup-pt Cdr)))

    (when (get Pt-C 'line)

      (if (= Reg-C 'b)
          (mov-line Pt-C Pt-Cdr)
          (del-line Pt-C))

      (lns> *ptr)
      (lns> *ptr))

    (set-ln-n> *ptr Pt-Cdr)

    (del> Pt-C T NIL)

    (cond

      ((and (= Reg-C 'a) Atom-Cdr)
       (set> Pt-B Cdr Pt-Cdr)
       (if (get Pt-Cdr 'line)
           (put @ 'p NIL)
           (put Pt-Cdr 'line
             (new '(+Line))))
       (pt> *ptr B 'a Pt-Cdr))

      ((and (= Reg-C 'a) (not Atom-Cdr))
       (set> Pt-B Cdr Pt-Cdr)
       (if (get Pt-Cdr 'line)
           (put @ 'p NIL)
           (put Pt-Cdr 'line
             (new '(+Line))))
       (pt> *ptr Cdr 'a))

      ((and (= Reg-C 'b) Atom-Cdr)
       (con> Pt-B Cdr Pt-Cdr)
       (pt> *ptr B 'b Pt-Cdr))

      ((and (= Reg-C 'b) (not Atom-Cdr))
       (con> Pt-B Cdr Pt-Cdr)
       (pt> *ptr Cdr 'b)))

    Pt-Cdr))


# DEL CUR
(de del-pair-2 (Pt-A Pt-B Pt-C Reg-B)

  # expected behavior: del "prev" link
  # NEED ALT to test properly

  (println 'bsp-x-a)

  (when (get Pt-B 'line)
    (pop-line Pt-B)
    (lns> *ptr))

  # Con A-B->CDR
  #   Dep if Reg-B is a/b

  # B could be pair or atom
  # X pair line: opt
  # Y pair line: always

  (let (BB (cdr (get Pt-B 'any))
        Pt-BB (if (pair BB)
                  (lup-pt @)
                  (get Pt-B 'b)))

    (if (= Reg-B 'a)
        (set> Pt-A (get Pt-BB 'any) Pt-BB)
        (con> Pt-A (get Pt-BB 'any) Pt-BB))

    (set-ln-n> *ptr Pt-BB))

  # pt to BB
  (pt> *ptr (get Pt-A 'any) Reg-B 'draw 'col)

  # mov to prev car
  (sub> *ptr T)

  # instead of sub>, just pt>

  # del last
  (del> Pt-B T NIL))
