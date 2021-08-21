#{

  Modes:

    * Text
      * Purpose: simulate typing text
      * ASCII = pair/sym
      * Enter = make newline and +Line
    * Cmd (non str sym fns)
      * Diff sectors on kb have diff functionality

    * Changing mode will change bindings
    * Least freq used cmds have most difficult finger gym

    * Use Ctrl/Alt to insert the character

  Key Priorities:
  * arstg mneio (home) == pair / atom
  * qwfpb jluy; (top) == ptr-s / repl
  * zxcdv kh,./ (bottom) == cua / lay


  EITHER USE MODE (Vim) or QUASI (Emacs)
  - default to mode
    - easier to help user than to relieve RSI

}#


(def '*binds-cmd-static

  '(((ksd~Tab) cmd-chg-mode)

    ((ksd~Alt-L ksd~Tab) cmd-make-char)
    ((ksd~Alt-R ksd~Tab) cmd-make-char)
    ((ksd~w)             cmd-make-nil)
    ((ksd~BackSpace)     bsp-pt)
    ((ksd~Delete)        del-pt)

    # DEBUG
    ((ksd~Control-L ksd~Return)    cmd-print-ptr)
    ((ksd~Control-L ksd~BackSpace) cmd-reset-start)))


(def '*binds-cmd-pair

  '(((ksd~q) make-pair-y)
    ((ksd~f) alt-reg)
    ((ksd~p) alt-lay)

    # Shifts
    #((ksd~r) cmd-rot-r)
    #((ksd~t) cmd-rot-l)
    #((ksd~y) cmd-flip/rev)

    ))


(def '*binds-cmd-atom

  # Atom <-> List
  # * pack/glue ""
  #   list -> str
  # * chop/split " "
  #   str  -> list

  # Str <-> Atom
  # * sym/intern:   str -> sym
  # * str/name,sym: sym -> str
  # * num/format:   str <-> num

  '(((ksd~n) cmd-conv)
    ((ksd~e) cmd-chop)))


(def '*binds-cmd-repl

  ######
  # Str/Code <-> Any
  # Any <-> Any

  # cmd-rd = str -> any
  # cmd-ev = any -> any
  # cmd-pr = any -> str (or use conv?)
  # cmd-rep  = str -> any -> str (all three)

  '(((ksd~l) cmd-read)
    ((ksd~u) cmd-eval)
    ((ksd~y) cmd-pp)
    ((ksd~;) cmd-rep)))


(def '*binds-cmd-line

  # no longer needed

  '(((ksd~n) cmd-ptr-ln-first)
    ((ksd~m) cmd-ptr-ln-last)

    ((ksd~Shift-L ksd~BackSpace)  cmd-del-line)
    ((ksd~Shift-L ksd~Return)     cmd-make-line)))


(def '*binds-cmd-cua

  # Most Microsoft Windows applications:
  #   Undo: Ctrl+Z or Alt+Backspace
  #   Redo: Ctrl+Y or Ctrl+Shift+Z
  # Most Apple Macintosh applications:
  #   Undo: Command-Z
  #   Redo: Command-Shift-Z or Command-Y

  # Cut* : push object once
  # Copy* : push same object repeatedly

  # ESC = exit
  # N = new
  # O = open
  # F = find
  # H = replace
  # G = goto

  '(((ksd~z) ((Ks) (println "Ctrl-L z: UNDO")))
    ((ksd~x) ((Ks) (println "Ctrl-L x: CUT")))
    ((ksd~c) ((Ks) (println "Ctrl-L c: COPY")))
    ((ksd~v) ((Ks) (println "Ctrl-L v: PASTE")))
    (ksd~Control-L ksd~Shift-L ksd~z) ((Ks) (println "Ctrl-Shift-L y: REDO"))))


(def '*binds-cmd-ptr-s

  ########################
  # Pointer Trans Semantic

  #((ksd~b) cmd-ptr-ls-first) # alt = lst

  # sart

  '(((ksd~s) cmd-ptr-up)
    ((ksd~a) cmd-ptr-left)
    ((ksd~r) cmd-ptr-down)
    ((ksd~t) cmd-ptr-right)))


(def '*binds-cmd-ptr-t

  #########################
  # Pointer Trans Euclidean

  # ((ksd~Right) cmd-trans-ptr-px)
  # ((ksd~Left)  cmd-trans-ptr-nx)
  # ((ksd~Up)    cmd-trans-ptr-py)
  # ((ksd~Down)  cmd-trans-ptr-ny)

  '())


(def '*binds-cmd-view

  ##############
  # Camera Trans
  # These should be used sparingly
  # similar to nav keys in Vim

  '(((ksd~Right) cmd-move-cam-px)
    ((ksd~Left)  cmd-move-cam-nx)
    ((ksd~Up)    cmd-move-cam-py)
    ((ksd~Down)  cmd-move-cam-ny)

    ((ksd~Prior) cmd-zoom-cam-in)
    ((ksd~Next)  cmd-zoom-cam-out)))


(def '*binds-cmd

  '(~*binds-cmd-static
    ~*binds-cmd-pair
    ~*binds-cmd-atom
    ~*binds-cmd-repl
    ~*binds-cmd-line
    ~*binds-cmd-cua
    ~*binds-cmd-ptr-s
    ~*binds-cmd-ptr-t
    ~*binds-cmd-view))


(de list-binds-cmd @
  (let L NIL
    (while (next)
      (for Bind (arg)
        (let ((Keys Rep Cmd) Bind
              Keys (mapcar '((K) (if (sym? K) (val K) @))
                           Keys)
              Rep (if (sym? Rep) (val Rep) @)
              Cmd (if (sym? Cmd) (val Cmd) @))
          (push 'L (list Keys Rep Cmd)))))
    L))
