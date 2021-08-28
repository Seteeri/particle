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

          #(ins-line-aft Pt-Ln Pt-Tgt)

          (unless (get Pt-Tgt 'line)
            (put Pt-Tgt 'line
              (new '(+Line) Ln Pt-Ln-Nxt)))

          (con-line Pt-Ln Pt-Tgt)

          (lay-*start)

          (top> Pt-Tgt)
          (draw> *ptr)

          (set-ln-n> *ptr Pt-Tgt)))))


(de ins-line-aft (Ln Po)

  (let Nxt (get Ln 'line 'n)

    (unless (get Po 'line)
      (put Po 'line
        (new '(+Line)
              Ln
              (unless (= Nxt Po) Nxt))))

    (if Ln

        (prog
          (put Ln 'line 'n Po)
          (when Nxt
            (unless (= Nxt Po)
              (put Nxt 'line 'p Po))))

        # Start of line
        (let? Nxt (get Ln 'line 'n)
          (put Ln 'line 'n Po)))))


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
