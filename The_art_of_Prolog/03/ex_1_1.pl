% X=<Y:-
% XとYは自然数であり、XはYより小さいか等しい。
0 =< X:-natural_number(X).
s(X) =< s(Y):- X =< Y.

% X<Y:-
% XとYは自然数であり、XはYより小さい。
0 < s(X):-0 =< X.
s(X) < s(Y):- X < Y.

% X>=Y:-
% XとYは自然数であり、XはYより大きいか等しい。
X >= 0:-natural_number(X).
s(X) >= s(Y):- X >= Y.

% X>Y:-
% XとYは自然数であり、XはYより大きい。
s(X) > 0:-X >= 0.
s(X) > s(Y):- X > Y.

% natural_number(X):-
% Xは自然数である。
natural_number(0).
natural_number(s(X)):- natural_number(X).

%% 使い道として考えられるもの
% ソート
% 最大、最小を求める
