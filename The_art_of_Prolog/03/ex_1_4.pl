% even(X):-
% Xは偶数である。
even(0).
even(s(s(X))):- natural_number(X), even(X).

% odd(X):-
% Xは奇数である。
odd(1).
odd(s(s(X))):- natural_number(X), odd(X).
