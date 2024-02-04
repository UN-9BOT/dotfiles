# NVIM CONFIG

## KEYBOARD SHORTCUTS


abbreviation:
- 0 -- start
- -1 -- end
- pos -- position
- ch -- character
- @@@ -- need 
- WTF -- no idea what it does

### (normal - without prefix)

- ` -- go to mark with pos
- - -- previous line (0 pos) {CUSTOM}
- = -- next line (-1 pos) {CUSTOM}
- backspace -- previous ch
- tab - NOTHING !!!!!!!!!!!!!!!!!!!!!!! @@@
- q -- NOTHING DO NOT APPLY
- w -- next word (0 pos)
- e -- next word (-1 pos)
- r -- change ch
- t -- find ch (before pos)
- y -- yank

  - yq -- nothing
  - yw -- yank word with space after
  - ye -- yank word
  - yr -- WTF
  - yt -- yank for find ch before pos
  - yy -- yank full line
  - yu -- NOTHING !!!!!!!!!!!!!! @@@
  - yi -- NOTHING !!!!!!!!!!!!!! @@@
  - yo -- NOTHING !!!!!!!!!!!!!! @@@
  - yp -- NOTHING !!!!!!!!!!!!!! @@@
  - ya -- NOTHING !!!!!!!!!!!!!! @@@
  - ys -- NOTHING !!!!!!!!!!!!!! @@@
  - ys -- NOTHING !!!!!!!!!!!!!! @@@
  - yf -- yank for find ch in cur pos
  - ygg -- yank everything to the beggining of file
  - yG -- yank everything to the end of file
  - yh -- yank previous ch
  - yj -- yank cur and next line
  - yk -- yank cur and previout line
  - yl -- yank next ch
  - y; -- yank WTF @@@
  - y' \* -- yank '* everything to the mark
  - yz -- WTF @@@
  - yx -- NOTHING !!!!!!!!!!!!!! @@@
  - yc -- NOTHING !!!!!!!!!!!!!! @@@
  - yv -- yank WTF @@@
  - yb -- yank backward up start word
  - yn -- yank WTF @@@
  - yn -- yank WTF @@@
  - ym -- NOTHING !!!!!!!!!!!!!! @@@
  - y, -- NOTHING !!!!!!!!!!!!!! @@@
  - y. -- NOTHING !!!!!!!!!!!!!! @@@
  - y/ -- yank and go to FlASH(plug) mode and search

- u -- cancel last change
- i -- insert mode
- o -- go to insert mode to next line
- p -- paste
- [ -- move

  - [[ -- tagbar(plug) next tag
  - [{ -- NOTHING !!!!!!!!!!!!!! @@@
  - and other

- ] -- ?????? !!!!!!!!!!!!!!!!! need desc combinations

  - ]] -- tagbar(plug) prev tag
  - ]} -- NOTHING !!!!!!!!!!!!!! @@@
  - and other

- \ -- NOTHING !!!!!!!!!!!!!! @@@
- CAPS-LOCK -- NOTHING \ DO NOT APPLY
- a -- go to insert mode after curent pos
- s -- FLASH {CUSTOM PLUGIN}
- d -- delete !!!!!!!!!!! need desc combinations
  
  - dd -- del line
  - dgg -- del everything to the beggining of file
  - dG -- del everything to the end of file
  - dh -- del previous ch
  - dj -- del cur and next line
  - dk -- del cur and previout line
  - dl -- del next ch
  - d; -- del WTF @@@
  - d' \* -- del '* everything to the mark
  - dz -- del WTF @@@
  - dx -- del WTF @@@
  - dc -- del WTF @@@
  - dvj -- del next line (without curent)
  - db -- del backward up start word
  - dn -- del WTF @@@
  - dn -- del WTF @@@
  - dm -- NOTHING !!!!!!!!!!!!!! @@@
  - d, -- NOTHING !!!!!!!!!!!!!! @@@
  - d. -- NOTHING !!!!!!!!!!!!!! @@@
  - d/ -- NOTHING !!!!!!!!!!!!!! @@@

- f -- find ch (inside pos)
- g -- ...

  - gq -- NOTHING !!!!!!!!!!!!!! @@@
  - gw -- NOTHING !!!!!!!!!!!!!! @@@
  - ge -- go to end previous word
  - gr -- COC(plug) references
  - gt -- COC(plug) type definition
  - gy -- TROUBLE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! DEL PLUG @@
  - gu -- NOTHING !!!!!!!!!!!!!! @@@
  - gi -- CUSTOM (del last ch in word and require LSP space)
  - go -- go to start position in file @@@
  - gp -- NOTHING !!!!!!!!!!!!!! @@@
  - ga -- COC(plug) start fix menu
  - gs -- NOTHING !!!!!!!!!!!!!! @@@
  - gd -- COC(plug)





  - gg -- go to beggining of file
  - G -- go to end of file
  - gh -- NOTHING !!!!!!!!!!!!!! @@@
  - gj -- NOTHING !!!!!!!!!!!!!! @@@
  - gk -- LSP(desc)
  - gl -- NOTHING !!!!!!!!!!!!!! @@@
  - g; -- go to previous change
  - g' \* -- NOTHING !!!!!!!!!!!!!! @@@
  - gz -- NOTHING !!!!!!!!!!!!!! @@@
  - gx -- go to LINK
  - gc -- NOTHING !!!!!!!!!!!!!! @@@
  - gv -- previous visual mode position
  - gb -- NOTHING !!!!!!!!!!!!!! @@@
  - gn -- go to WTF @@@
  - gm -- go to end line ($)
  - g, -- go to last change
  - g. -- NOTHING !!!!!!!!!!!!!! @@@
  - g/ -- NOTHING !!!!!!!!!!!!!! @@@
- h -- move left
- j -- move down
- k -- move up
- l -- move right
- ; -- ?????????? !!!!!!!!!!!!!!!! need desc combinations
- ' -- go to mark NO pos
- z -- ?????????????? !!!!!!!!!!!!!!!!!! need desc combinations
- x -- del curent ch
- c - change !!!!!!!!!!!!! need desc combinations
- v - visual mode
- b - backward word
- n - go to search mode and find next overlap
- m - mark *
- , - !!!!!!!!!????????????? need desc combinations
- . - repeat last action
- / - search mode for next word

### LEADER

- leader ~ --
- leader 1 --
- leader ! --
- leader 2 --
- leader @ --
- leader 3 --
- leader $ --
- leader 4 --
- leader 5 --
- leader 6 --
- leader 7 --
- leader 8 --
- leader 9 --
- leader 0 --
- leader - --
- leader = --
- leader backspace --
- leader tab
- leader q --
- leader w --
- leader e --
- leader r --
- leader t --
- leader y --
- leader u --
- leader i --
- leader o --
- leader p --
- leader [ --
- leader ] --
- leader \ --
- leader caps-lock --
- leader a --
- leader s --
- leader d --
- leader f --
- leader g --
- leader h --
- leader j --
- leader k --
- leader l --
- leader ; --
- leader ' --
- leader z --
- leader x --
- leader c --
- leader v --
- leader b --
- leader n --
- leader m --
- leader , --
- leader . --
- leader / --

### ALT

### CTRL

### SHIFT

### ENTER

### BACKSPACE

### TAB

### CAPSLOCK

### q

### w (w)

### e (e)

### r (R)

### t (T)

### y (Y)

### u (U)

### i (I)

### o (O)

### p (P)

### [ ({)

### ] (})

### \ (|)

### a (A)

### s (S)

### d (D)

### f (F)

### g (G)

### h (H)

### j (J)

### k (K)

### l (L)

### ; (:)

### ' (")

### z (Z)

### x (X)

### c (C)

### v (V)

### b (B)

### n (N)

### m (M)

### , (<)

### . (>)

### / (?)

### F*

- F1
- F2
- F3
- F4
- F5
- F6
- F7
- F8
- F9
- F10
- F11
- F12
