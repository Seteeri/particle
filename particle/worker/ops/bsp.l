(de bsp-pt ()

  (let ((C Pt-C Reg-C
         B Pt-B Reg-B
         A Pt-A)
        (refs-2> *ptr))

    # pass refs-2> list...plist or class?

    (cond

      ((isa '+Atom Pt-C)

        # fn format
        # cmd-layb-layc

        (cond

          ((and (lay-x?> Pt-B) (= Reg-C 'a)) (bsp-x-a Pt-A Pt-B Pt-C Reg-B))
          ((and (lay-x?> Pt-B) (= Reg-C 'b)) (bsp-x-b Pt-A Pt-B Pt-C Reg-B))

          ((and (lay-y?> Pt-B) (= Reg-C 'a)) (bsp-y-a Pt-A Pt-B Pt-C))
          ((and (lay-y?> Pt-B) (= Reg-C 'b)) (bsp-y-b Pt-A Pt-B Pt-C))))

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

  (println 'bsp-xyb-xy)

  (when (get Pt-B 'line)

    (cond

      ((and (= Reg-B 'b) (lay-y?> Pt-B) (= Reg-C 'a) (lay-x?> Pt-C)) # last 2 checks needed?
        # x
        #   .
        # y x
       (pop-line Pt-B))

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

# 2 opts:
# 1. del pair
# 2. del atom by replacing with NIL

(de bsp-x-a (Pt-A Pt-B Pt-C Reg-B)

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

  # Opt:
  # 1. Move to next pair
  # 2. Move to next pair car
  #
  # 2 seems expected
  (sub> *ptr T)

  # instead of sub>, just pt>

  # del last
  (del> Pt-B T NIL))


(de bsp-x-b (Pt-A Pt-B Pt-C Reg-B)

  #{

    If ln del, auto con line

  }#

  # Remove B

  # if B has line, pop it
  # auto link A -> C
  (when (get Pt-B 'line)
    (pop-line Pt-B)
    (lns> *ptr))

  # set cur ln as needed
  #(set-ln-n> *ptr Pt-C)

  # del it with car, skip cdr
  (del> Pt-B T NIL)

  # Con A-C
  #   Dep if Reg-B is a/b

  # creates line as needed
  (if (= Reg-B 'a)
      (set> Pt-A (get Pt-C 'any) Pt-C)
      (con> Pt-A (get Pt-C 'any) Pt-C))

  (set-ln-n> *ptr Pt-C)

  # ignore draw
  # can set any directly
  (with *ptr
    (=: any (get Pt-A 'any))
    (=: reg Reg-B)))


(de bsp-y-a (Pt-A Pt-B Pt-C))


(de bsp-y-b (Pt-A Pt-B Pt-C))
