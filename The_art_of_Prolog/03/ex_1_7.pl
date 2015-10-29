% gcd(X, Y, Z):-
% Zは自然数X、Yの最大公約数である。
gcd(X, X, X).
gcd(X, Y, Z):- X > Y, plus(X, X2, Y), gcd(X2, Y, Y).
gcd(X, Y, Z):- Y > X, plus(Y, Y2, X), gcd(Y2, X, X).
