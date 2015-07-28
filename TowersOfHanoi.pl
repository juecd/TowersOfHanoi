/* Hanoi */
concatenate([], List2, List2).
concatenate([H|T1], List2, [H|T2]) :-
      concatenate(T1, List2, T2).

to(peg1, peg2).
to(peg1, peg3).
to(peg2, peg1).
to(peg2, peg3).
to(peg3, peg1).
to(peg3, peg2).

/* "to peg" can be _ */
move(State, to(peg1, peg2), [Peg1T, [Peg1H], Peg3]):- /* Disregard is a complete peg (list) */
	State = [[Peg1H|Peg1T]|Rest],
	Rest = [[]|Rest2],
	Rest2 = [Peg3|_].

move(State, to(peg1, peg3), [Peg1T, Disregard, [Peg1H]]):-
	State = [[Peg1H|Peg1T]|Rest],
	Rest = [Disregard|Rest2],
	Rest2 = [[]|_].

move(State, to(peg2, peg1), [[Peg2H], Peg2T, Peg3]):-
	State = [[]|Rest],
	Rest = [[Peg2H|Peg2T]|Rest2],
	Rest2 = [Peg3|_].

move(State, to(peg2, peg3), [Disregard, Peg2T, [Peg2H]]):-
	State = [Disregard|Rest],
	Rest = [[Peg2H|Peg2T]|Rest2],
	Rest2 = [[]|_].

move(State, to(peg3, peg1), [[Peg3H], Disregard, Peg3T]):-
	State = [[]|Rest],
	Rest = [Disregard|Rest2],
	Rest2 = [[Peg3H|Peg3T]|_].

move(State, to(peg3, peg2), [Disregard, [Peg3H], Peg3T]):-
	State = [Disregard|Rest],
	Rest = [[]|Rest2],
	Rest2 = [[Peg3H|Peg3T]|_].


/* Or, "to peg" can have an element in it */
move(State, to(peg1, peg2), [Peg1T, XX, Peg3]):- /* Disregard is a complete peg (list) */
	State = [[Peg1H|Peg1T]|Rest],
	Rest = [[Peg2H|Peg2T]|Rest2],
	Rest2 = [Peg3|_],
	Peg1H < Peg2H,
	concatenate([Peg1H], [Peg2H|Peg2T], XX).

move(State, to(peg1, peg3), [Peg1T, Disregard, XX]):-
	State = [[Peg1H|Peg1T]|Rest],
	Rest = [Disregard|Rest2],
	Rest2 = [[Peg3H|Peg3T]|_],
	Peg1H < Peg3H,
	concatenate([Peg1H], [Peg3H|Peg3T], XX).

move(State, to(peg2, peg1), [XX, Peg2T, Peg3]):-
	State = [[Peg1H|Peg1T]|Rest],
	Rest = [[Peg2H|Peg2T]|Rest2],
	Rest2 = [Peg3|_],
	Peg2H < Peg1H,
	concatenate([Peg2H], [Peg1H|Peg1T], XX).

move(State, to(peg2, peg3), [Disregard, Peg2T, XX]):-
	State = [Disregard|Rest],
	Rest = [[Peg2H|Peg2T]|Rest2],
	Rest2 = [[Peg3H|Peg3T]|_],
	Peg2H < Peg3H,
	concatenate([Peg2H], [Peg3H|Peg3T], XX).

move(State, to(peg3, peg1), [XX, Disregard, Peg3T]):-
	State = [[Peg1H|Peg1T]|Rest],
	Rest = [Disregard|Rest2],
	Rest2 = [[Peg3H|Peg3T]|_],
	Peg3H < Peg1H,
	concatenate([Peg3H], [Peg1H|Peg1T], XX).

move(State, to(peg3, peg2), [Disregard, XX, Peg3T]):-
	State = [Disregard|Rest],
	Rest = [[Peg2H|Peg2T]|Rest2],
	Rest2 = [[Peg3H|Peg3T]|_],
	Peg3H < Peg2H,
	concatenate([Peg3H], [Peg2H|Peg2T], XX).

towerOfHanoi(X, X, []). /* Reached goal state */
towerOfHanoi(Init, Goal, [M|Moves]):- /* Otherwise, */
	move(Init, M, NewState), towerOfHanoi(NewState, Goal, Moves).