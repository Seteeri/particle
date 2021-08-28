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
