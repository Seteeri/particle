
pt> NIL $177172202766320 *start
pt> $177172202766320 $177172202761476 NIL
make-pair-y "B ATOM/NIL"
make-pair-b-atom

pt> $177172202766320 $177172203033712 (NIL)
pt> $177172203033712 $177172203041161 NIL
WARNING: uncol> Missing col: $177172203033712 (NIL)
(de lst-x-atom-b NIL
   (cmd-ptr-right)
   (make-pair-y)
   (ver-start
      'lst-x-atom-b
      '(((+Pair)
            (NIL)
            y
            T
            T
            NIL
            (4214357 0 0)
            T
            (2408204 2408204)
            (NIL T) )
         ((+Nil)
            NIL
            x
            NIL
            NIL
            T
            (5418459 0 0)
            T
            (1204102 0)
            (NIL NIL) )
         ((+Nil)
            NIL
            x
            NIL
            NIL
            T
            (4214357 -2408204 0)
            T
            (1204102 0)
            (T NIL) ) ) ) )


pt> NIL NIL NIL
pt> $177172202766320 $177172203056141 NIL
ins-b-atom

pt> $177172202766320 $177172203056141 NIL
pt> $177172203070213 $177172203056141 NIL

pt-bwd> NIL $177172203056141 b
pt-bwd> (NIL) $177172203070213 NIL
pt-bwd> NIL NIL

pt> $177172203070213 $177172203056141 NIL
pt> $177172203070213 $177172203056141 NIL
