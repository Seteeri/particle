(de bsp-pt ()

  (let ((C Pt-C Reg-C
         B Pt-B Reg-B
         A Pt-A)
        (refs-2> *ptr))

    # pass refs-2> list...plist or class?

    (cond

      # fn format
      # cmd-layb-layc

      ((isa '+Atom Pt-C)
        (cond
          ((and (lay-x?> Pt-B) (= Reg-C 'a))
            (bsp-x-a Pt-A Pt-B Pt-C))
          ((and (lay-y?> Pt-B) (= Reg-C 'a))
            (bsp-y-a Pt-A Pt-B Pt-C))
          (T
            (bsp-xy-b Pt-A Pt-B Pt-C Reg-B))))

      ((isa '+Pair Pt-C)
        (bsp-pair Pt-A Pt-B Pt-C Reg-A Reg-B Reg-C))

      (T
        (quit "bsp-pt: unknown cls")))

    (lay-*start)

    (top-ref> *ptr)
    (draw> *ptr)))

# pair

# Two ops for newline:
# 1. Move Y pair to end of prev line and remove line
# 2. Keep Y pair
#
# 2 makes more sense
# Use explicit cmd to del line (formatting)

(de bsp-pair (Pt-A Pt-B Pt-C Reg-A Reg-B Reg-C)

  (println 'bsp-pair)

  (when (get Pt-B 'line)

    (cond

      # last 2 checks needed?
      ((and (= Reg-B 'b) (lay-y?> Pt-B) (= Reg-C 'a) (lay-x?> Pt-C))
        # x
        #   .
        # y x

        # pop twice - one for X, one for Y
        # since line is removed
        # remove line from C
       (del-line Pt-C)
       (pop-line Pt-B)
       (lns> *ptr))

      ((or (= Reg-B 'a) (lay-y?> Pt-B))
        # ...
        # y y x/y
        #
        # or
        #
        # ...
        # y y
        #   x/y
        (mov-line Pt-B Pt-C))

      (T
        (pop-line Pt-B)))

    (lns> *ptr))

  (if (and (lay-y?> Pt-B) (= Reg-C 'a))
      (del> Pt-B NIL T)  # del B with cdr, keep car
      (del> Pt-B T NIL)) # del B with car, keep cdr

  # con A -> C
  (if (= Reg-B 'a)
      (set> Pt-A (get Pt-C 'any) Pt-C)
      (con> Pt-A (get Pt-C 'any) Pt-C))

  # ptr moves, but ref is the same
  # update ptr
  (with *ptr
    (=: any (get Pt-A 'any))
    (=: reg Reg-B)))

# atom


(de bsp-x-a (Pt-A Pt-B Pt-C)

  # this will make prv pair nil
  # will not work properly with y

  (println 'bsp-xy-a)

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

  (let Pt-Str (gen-point NIL 'x NIL T)

    # Set new car, del old one
    (set> Pt-A NIL Pt-Str T)

    # Pt to Pt-A car
    (pt> *ptr (get Pt-A 'any) 'a 'draw 'col)))


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
