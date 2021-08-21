(de make-str (Str)

  (let ((C Pt-C Reg-C
         B Pt-B Reg-B
         A Pt-A)      (refs-2> *ptr))

    (cond

      ((isa '+Atom Pt-C)

        (cond

          ((and (lay-x?> Pt-B) (= Reg-C 'a)) (mak-str-x-a Str 'a Pt-B Pt-C))
          ((and (lay-x?> Pt-B) (= Reg-C 'b)) (mak-str-x-b Str Pt-B Pt-C))

          ((and (lay-y?> Pt-B) (= Reg-C 'a)) (mak-str-y-a Str Pt-B Pt-C))
          ((and (lay-y?> Pt-B) (= Reg-C 'b)) (mak-str-y-b Str Pt-B Pt-C))))

      ((isa '+Pair Pt-C)

        (cond

          ((and (lay-x?> Pt-B) (= Reg-C 'b) (lay-x?> Pt-C)) (mak-str-xb-x Str Pt-B Pt-C))
          #((and (lay-x?> Pt-B) (= Reg-C 'a) (lay-x?> Pt-C)) (mak-str-xa-x Str Pt-B Pt-C))
          #((and (lay-x?> Pt-B) (= Reg-C 'a) (lay-y?> Pt-C)) (mak-str-xa-y Str Pt-B Pt-C))
          #((and (lay-x?> Pt-B) (= Reg-C 'b) (lay-y?> Pt-C)) (mak-str-xb-y Str Pt-B Pt-C))

          ((and (lay-y?> Pt-B) (= Reg-C 'a) (lay-x?> Pt-C)) (mak-str-ya-x Str Pt-B Pt-C))
          ((and (lay-y?> Pt-B) (= Reg-C 'b) (lay-x?> Pt-C)) (mak-str-yb-x Str Pt-B Pt-C))

          ((and (lay-y?> Pt-B) (= Reg-C 'a) (lay-y?> Pt-C)) (mak-str-ya-y Str Pt-B Pt-C))
          ((and (lay-y?> Pt-B) (= Reg-C 'b) (lay-y?> Pt-C)) (mak-str-yb-y Str Pt-B Pt-C))))

      (T
        (quit "make-str: unknown cls")))))
