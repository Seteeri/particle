(de make-str-x-a (Str Reg-C Pt-B Pt-C)

  (println 'make-str-x-a)

  (let (B (get Pt-B 'any)
        Pt-Str (gen-point Str 'x NIL T))

    (if (= Reg-C 'a)
        (set> Pt-B Str Pt-Str T)
        (con> Pt-B Str Pt-Str T))

    (when (get Pt-C 'line)
      (mov-line Pt-C Pt-Str)
      (lns> *ptr))
    (set-ln-n> *ptr Pt-Str)

    # use pt to col ref also
    # new pt does not have 'col
    # so warning will print
    (pt> *ptr B Reg-C 'draw 'col)

    (lay-*start)

    # Move to next car
    (when (and (pair B)
               (pair (cdr B))
               (atom (car @)))
      (sup> *ptr)
      (nex> *ptr)
      (sub> *ptr T))))


(de make-str-x-b (Str Pt-B Pt-C)
  (println 'make-str-x-b)
  #(make-str-x-a Str 'b Pt-B Pt-C)
  (con-b-pair-x Str Pt-B Pt-C))


(de make-str-y-a (Str Pt-B Pt-C)
  (println 'make-str-y-a)
  (con-a-pair-x Str Pt-B Pt-C))


(de make-str-y-b (Str Pt-B Pt-C)
  (println 'make-str-y-b)
  (con-b-pair-x Str Pt-B Pt-C))
