on(a, b).
on(a, c).
on(b, d).
on(c, d).
on(d, e).
on(f, g).

above(Block, Block).
above(Block1, Block2):-
    on(Block1, Block),
    above(Block, Block2).
