# Mov to +Line?

(de make-line ()

  # Only applies to X Pair Cdr

  # Add line to cur line

  (let ((C Pt-Tgt Reg-C
         B Pt-B Reg-B
         A Pt-A)
        (refs-2> *ptr)
       Pt-Ln (c-lns> *ptr)
       Pt-Ln-Nxt (get Pt-Ln 'line 'n))

    (if (get Pt-Tgt 'line)

        (prinl "make-line: +Line exists")

        (prog

          (app-line Pt-Ln Pt-Tgt)

          (lay-*start)

          (top> Pt-Tgt)
          (draw> *ptr)

          (set-ln-n> *ptr Pt-Tgt)))))


(de app-line (A-Pt B-Pt)

  # Ensures B-Pt has 'line
  # Ensures next line links back also

  # Y pair cannot have prev line
  # only next

  (let Nxt (get A-Pt 'line 'n)

    (unless (get B-Pt 'line)

      (put B-Pt 'line
        (new '(+Line)
              A-Pt
              (unless (= Nxt B-Pt) Nxt))))

    (if A-Pt

        (prog
          (put A-Pt 'line 'n B-Pt)
          (when Nxt
            (unless (= Nxt B-Pt)
              (put Nxt 'line 'p B-Pt))))

        # Start of line
        (let? Nxt (get A-Pt 'line 'n)
          (put A-Pt 'line 'n B-Pt)))))


(de con-line (A-Pt B-Pt)
  ~(assert (not (= A-Pt B-Pt)))
  (put A-Pt 'line 'n B-Pt)
  (put B-Pt 'line 'p A-Pt))


(de del-line (Po)
  (pop-line Po)
  (put Po 'line NIL))


(de pop-line (Po)

  (let? L (get Po 'line)

    (when (get L 'p)
      (put @ 'line 'n (get L 'n)))

    (when (get L 'n)
      (put @ 'line 'p (get L 'p)))))


(de mov-line (Src Dst)

  (let (Nl (get Src 'line)
        Nxt (get Nl 'n))

    (when (get Nl 'p)
      (put @ 'line 'n Dst))

    (when Nxt
      (put Nxt 'line 'p Dst))

    (when (= Nxt Dst)
      (put Nl 'n))

    (put Dst 'line Nl))

  (put Src 'line)

  #(println 'mov-line "Put line: " Src (get Src 'any) " -> " Dst (get Dst 'any))
  )


(de del-line-cur ()

  #{

    [X]
     .

    [X]
     .

    [X]
     .

  }#

  (del-line (c-lns> *ptr))

  (lns> *ptr)

  (lay-*start)

  (mov-⇲ (c-lns> *ptr))

  (with *ptr
    (top> (if (: atom) @ (lup-pt (: pair)))))
  (draw> *ptr))
