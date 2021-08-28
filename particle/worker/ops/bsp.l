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
        (if (= Reg-C 'a)
            (bsp-xy-a Pt-A Pt-B Pt-C))
            (bsp-xy-b Pt-A Pt-B Pt-C Reg-B))

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

(de bsp-xy-a (Pt-A Pt-B Pt-C)
  # Replace Pt-A car with NIL
  # This will update ptr and handle lines
  (make-str-x-a NIL 'a Pt-A (get Pt-A 'a)'skip-mov))


(de bsp-xy-b (Pt-A Pt-B Pt-C Reg-B)

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
    (=: reg Reg-B)))'
