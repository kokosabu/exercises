subsequence([X|Xs], [X|Ys]):-subsequence(Xs, Ys).
subsequence(Xs, [Y|Ys]):-subsequence(Xs, Ys).
subsequence([], Ys).
