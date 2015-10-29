% fib(N, F):-
% FはN番目のフィボナッチ数である。
fib(1, 1).
fib(2, 1).
fib(s(s(N)), F):-fib(N, F1), fib(s(N), F2), plus(F1, F2, F).
