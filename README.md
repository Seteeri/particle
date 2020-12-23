    ____                   _     _          _
    |  _ \    __ _   _ __  | |_  (_)   ___  | |   ___
    | |_) |  / _` | | '__| | __| | |  / __| | |  / _ \
    |  __/  | (_| | | |    | |_  | | | (__  | | |  __/
    |_|      \__,_| |_|     \__| |_|  \___| |_|  \___|


> The Grid. A digital frontier. I tried to picture clusters of
information as they moved through the computer. What did they look like?
 Ships? Motorcycles? Were the circuits like freeways? I kept dreaming of
  a world I thought I'd never see. And then one day . . .

---

Particle is a PicoLisp userland.

Particle is the realization of my vision of the human computer interaction model. I want to take the extensibility, dynamicness, and cohesion of past Lisp Machines, Smalltalk enivronments, and others, and evolve the text interface to empower as many users as possible to take advantage of the increasing integration of the digital world, the ever-growing computing power, and ubiquitousness of the internet.

I believe the way for a future FOSS system does not lie solely with the desktop - that has been settled - but with the computing needs of tomorrow.

Plans are to initially support Linux, Android, Mac. Windows requires WSL or virtualization due to POSIX requirements.

The ultimate goal of Particle is to create a Lispy userland, eventually replacing the init system and encompassing all layers above that, through a more pragmatic and gradual approach.

The target audience consists of information/knowledge workers, power users, and programmers.

* To ameliorate the following sentiments:
  * "I'm tired of needing a new application for every different task."
  * "I'm tired of needing a new data format for every different task."
  * "I'm tired of not being able to connect and use my data in other applications."
  * "I'm tired of not being able to share my data with others."
  * "I'm tired of needing markup, native-code, JIT-Code, scripting languages, database languages, domain specific languages, etc..."
  * "I want to use the full power of the computer."
  * "I want the computer to meet me more than half way."

# Preview

![PARTICLE SCREENSHOT](https://github.com/Seteeri/Particle/blob/master/art/screenshot-2.png)

These colored text are representations for the fundamental types; the use of color allows the removal of some character tokens to optimize drawing and information efficiency:

* Strings do not have double quotes; it is possible to remove other identifying tokens such as curly brackets and the dollar sign.
* Pairs use dot notation and terminate with the `NIL` symbol for proper lists, or arbitrary data for improper lists
  * Parentheses are possible, for the more traditional types ;)
* Lines are double-spaced to vertically delimit pairs and to allow room for the pointer name/mode (rather than in-between pairs like conventional text cursors)
* The pointer is also a symbol!

# Goals

* To remember everything, an extension of the human brain
  * Evernote by Stepan Pachikov
* To structure a system in such a way that it can be described, explained, and understood as a whole
  * Oberon OS by Niklaus Wirth at ETH Zürich

# Inspirations

* Childhood:

  * Transformers: Beast Wars, Digimon, Reboot, Tron - bridging the divide between the digital world and reality, users and programs

* Program (no particular order):

  * Emacs by RMS
  * Vim by Bill Joy
  * Hypercard by Bill Atkinson
  * Excel by MS
  * OpenDoc by Apple
  * Lisp Machines by Xerox PARC and MIT
  * Singularity by MS
  * WinFS by MS

* User (no particular order):
  * John McCarthy - LISP
  * Jeff Raskin - "The Humane Interface"
  * E.C. Ciccarelli - "Presentation Based User Interfaces"
  *	Charles Simonyi - "Intentional Programming"
  * Alan Kay
  * Sir Tim Berners-Lee
  * Paul Graham
  * Peter Norvig
  * Brett Victor
  * Robert Strandh
  * Chris Schafmeister
  * Randy Pausch

# UI

...

If the user must perform a search for context-related commands (rather than one they have instantly conjured up), this means the system has failed the user. In other words, the system should provide possible future directions based on the current context object at all times.

There are no overlapping or modal windows and no focus stealing.

To improve discoverability:
* System always provides mode indication and feedback at the user's locus of attention like a painting/drawing program
* Search always available and conveniently accessible like JetBrains double Shift command


*WIP*
* Keyboard-driven first
* Local/offline data first - no cloud dependency
* Database (Lisp data)
  * Persistent symbols (external symbols) - first-class data type
  * NoSQL, full ACID, replication, journaling
  * [PicoLisp DB Vs ORM](https://picolisp.com/wiki/?pilvsorm)

# Manual

* [Introduction](https://github.com/Seteeri/Particle/tree/master/doc/INTRO.md)

* [Premise](https://github.com/Seteeri/Particle/tree/master/doc/PREMISE.md)

* [Roadmap to PID 1](https://github.com/Seteeri/Particle/tree/master/doc/INTRO.md)

* [The Road Beyond](https://github.com/Seteeri/Particle/tree/master/doc/INTRO.md)

* [Installation](https://github.com/Seteeri/Particle/tree/master/doc/INTRO.md)

* [Architecture](https://github.com/Seteeri/Particle/tree/master/doc/INTRO.md)

  * [UI](https://github.com/Seteeri/Particle/tree/master/doc/UI.md)

  * [Toolkit](https://github.com/Seteeri/Particle/tree/master/doc/TK.md)

  * [API](https://github.com/Seteeri/Particle/tree/master/doc/API.md)

* [FAQ](https://github.com/Seteeri/Particle/tree/master/doc/FAQ.md)

  * Plain text is universal.

  * Pictographs are a poor solution; only text can represent code.

  * Smalltalk VMs never became mainstream.

  * Attempts at structured/projectional editors have largely failed and the ones that have succeeded are niche.

  * Does this roughly offer the same benefits that the old lisp machines provided?

* [Relevant Anecdotes](https://github.com/Seteeri/Particle/tree/master/doc/INTRO.md)

  * [LISP](https://github.com/Seteeri/Particle/tree/master/doc/ANECDOTES-LISP.md)

  * [CLIM](https://github.com/Seteeri/Particle/tree/master/doc/ANECDOTES-CLIM.md)

  * [EMACS](https://github.com/Seteeri/Particle/tree/master/doc/ANECDOTES-EMACS.md)

  * [WASM](https://github.com/Seteeri/Particle/tree/master/doc/ANECDOTES-WASM.md)

  * [MISC](https://github.com/Seteeri/Particle/tree/master/doc/ANECDOTES-MISC.md)

# License

Apache License 2.0

