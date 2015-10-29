% div(X, Y, Z):-
% X、Y、Zは自然数であり、ZはXとYの商である。
div(X, Y, Z):- X < Y.
div(X, Y, Z):- plus(X, X2, Y), div(X2, Y, Z).

% plus(X, Y, Z):-
% X、Y、Zは自然数であり、ZはXとYの和である。
plus(0, X, X):-natural_number(X).
plus(s(X), Y, s(Z)):-plus(X, Y, Z).

% natural_number(X):-
% Xは自然数である。
natural_number(0).
natural_number(s(X)):- natural_number(X).
