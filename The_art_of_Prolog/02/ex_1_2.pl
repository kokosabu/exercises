father(terach,abraham).
father(terach,nachor).
father(terach,haran).
father(abraham,isaac).
father(haran,lot).
father(haran,milah).
father(haran,yiscah).

mother(sarah,isaac).

male(terach).
male(abraham).
male(nachor).
male(haran).
male(isaac).
male(lot).

female(sarah).
female(milcah).
female(yiscah).

parent(X,Y):-father(X,Y).
parent(X,Y):-mother(X,Y).

uncle(Uncle,NieceOrNephew):-
	brother(Uncle,Parent),parent(Parent,NieceOrNephew).

niece(Niece, UncleOrAunt):-
	sibling(UncletOrAunt,Parent),parent(Parent,Niece), female(Niece).

sibling(Sib1,Sib2):-
	father(Father,Sib1), father(Father,Sib2),
	mother(Mother,Sib1), mother(Mother,Sib2),
	Sib1\=Sib2.

cousin(Cousin1,Cousin2):-
	parent(Parent1,Cousin1),
	parent(Parent2,Cousin2),
	sibling(Parent1,Parent2).

brother(Brother,Sib):-
	parent(Parent,Brother),
	parent(Parent,Sib),
	male(Brother),
	Brother \= Sib.

sister(Sister,Sib):-
	parent(Parent,Sister),
	parent(Parent,Sib),
	female(Sister),
	Sister \= Sib.

mother_in_law(MotherInLaw, ChildInLaw) :-
	married_couple(MotherInLaw, Father),
	father(Father, ChildInLaw).
brother_in_law(BrotherInLaw, SiblingInLaw) :-
	parent(Parent1, BrotherInLaw),
	parent(Parent2, SiblingInLaw),
	married_couple(Parent1, Parent2).
brother_in_law(BrotherInLaw, SiblingInLaw) :-
	parent(Parent1, BrotherInLaw),
	parent(Parent2, SiblingInLaw),
	married_couple(Parent2, Parent1).
son_in_law(SonInLaw, SonInParent) :-
	parent(Parent, SonInLaw),
	married_couple(Parent, SonInParent).
