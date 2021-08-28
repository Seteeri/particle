(de bsp-x-a (Pt-A Pt-B Pt-C)

  # this will make prv pair nil
  # will not work properly with y

  (println 'bsp-x-a)

  # Replace Pt-A car -> NIL
  # Pt to Pt-A car

  # Handle case:
  # x x
  # . .
  #
  #   * [NIL]
  # y x   x .
  #   NIL .
  #
  # .

  (if (lay-y?> Pt-A)

      # no mov
      (make-str-x-a NIL 'a Pt-B Pt-C 'skip-mov)

      (let Pt-Str (gen-point NIL 'x NIL T)

        # Set new car, del old one
        (set> Pt-A NIL Pt-Str T)

        # Pt to Pt-A car
        (pt> *ptr (get Pt-A 'any) 'a 'draw 'col))))


(de bsp-y-a (Pt-A Pt-B Pt-C)

  (println 'bsp-y-a)

  # A=Pair
  # Reg-B=X/Y
  # B=Y-Pair
  # C=atom <- ptr

  # Con A-B-Cdr
  # Del A+car

  (del-line Pt-C)
  (lns> *ptr)
  (del-line Pt-B)
  (lns> *ptr)

  # del it with car, skip cdr
  (del> Pt-B T NIL)

  (let (BB (cdr (get Pt-B 'any))
        Pt-BB (if (pair BB)
                  (lup-pt @)
                  (get Pt-B 'b))
        Ln (c-lns> *ptr)) # ln before Y

      (con> Pt-A (get Pt-BB 'any) Pt-BB)
      (app-line Ln Pt-BB)
      (set-ln-n> *ptr Pt-BB))

  # Pt to Pt-A car
  (pt> *ptr (get Pt-A 'any) 'b 'draw 'col))


(de bsp-xy-b (Pt-A Pt-B Pt-C Reg-B)

  (println 'bsp-xy-b)

  # if B has line, pop it
  # auto link A -> C
  (when (get Pt-B 'line)
    (pop-line Pt-B)
    (lns> *ptr))

  # del it with car, skip cdr
  (del> Pt-B T NIL)

  # Con A-C
  #   Dep if Reg-B is a/b

  # Note, con> and set> create lines
  (if (= Reg-B 'a)
      (set> Pt-A (get Pt-C 'any) Pt-C)
      (con> Pt-A (get Pt-C 'any) Pt-C))

  (set-ln-n> *ptr Pt-C)

  # ignore draw
  # can set any directly
  (with *ptr
    (=: any (get Pt-A 'any))
    (=: reg Reg-B)))
