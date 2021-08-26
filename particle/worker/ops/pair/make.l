(de make-pair-y (Str)

  (let ((C Pt-C Reg-C
         B Pt-B Reg-B
         A Pt-A)
        (refs-2> *ptr))

    (cond

      ((isa '+Atom Pt-C)

        (cond

          # should be consistent

          ((and (lay-x?> Pt-B) (= Reg-C 'a)) (make-pair-x-a Pt-B Pt-C))
          ((and (lay-x?> Pt-B) (= Reg-C 'b)) (make-pair-x-b Pt-B Pt-C))

          ((and (lay-y?> Pt-B) (= Reg-C 'a)) (make-pair-y-a Pt-B Pt-C))
          ((and (lay-y?> Pt-B) (= Reg-C 'b)) (make-pair-y-b Pt-B Pt-C))))

      ((isa '+Pair Pt-C)

        (cond

          ((and (lay-x?> Pt-B) (= Reg-C 'a) (lay-x?> Pt-C)) (make-pair-xa-x Pt-B Pt-C))
          ((and (lay-x?> Pt-B) (= Reg-C 'a) (lay-y?> Pt-C)) (make-pair-xa-y Pt-B Pt-C))
          ((and (lay-x?> Pt-B) (= Reg-C 'b) (lay-x?> Pt-C)) (make-pair-xb-x Pt-B Pt-C))
          ((and (lay-x?> Pt-B) (= Reg-C 'b) (lay-y?> Pt-C)) (make-pair-xb-y Pt-B Pt-C))

          ((and (lay-y?> Pt-B) (= Reg-C 'a) (lay-x?> Pt-C)) (make-pair-ya-x Pt-B Pt-C))
          ((and (lay-y?> Pt-B) (= Reg-C 'b) (lay-x?> Pt-C)) (make-pair-yb-x Pt-B Pt-C))

          ((and (lay-y?> Pt-B) (= Reg-C 'a) (lay-y?> Pt-C)) (make-pair-ya-y Pt-B Pt-C))
          ((and (lay-y?> Pt-B) (= Reg-C 'b) (lay-y?> Pt-C)) (make-pair-yb-y Pt-B Pt-C))))

      (T
        (quit "make-str: unknown cls")))))
