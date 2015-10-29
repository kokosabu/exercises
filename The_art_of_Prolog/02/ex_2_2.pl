lecture(Lecturer, Course):-
    course(Course, Time, Lecturer, Location).

duration(Course, Length):-
    course(Course, time(Day,Start,Finish), Lecturer, Location),
    plus(Start, Length, Finish).

teaches(Lecturer, Day):-
    course(Course, time(Day,Start,Finish), Lecturer, Location).

occupied(Room, Day, Time):-
    course(Course, time(Day,Start,Finish), Lecturer,
           location(Building,Room)),
    Start =< Time, Time =< Finish.

location(Course, Building):-
    course(Course, Time, Lecturer, location(Building,classroom)).

busy(Lecturer, Time):-
    course(Course, time(Day,Start,Finish), Lecturer, Location),
    Start =< Time, Time =< Finish.

cannot_meet(Lecturer1, Lecturer2):-
    course(Course, Time, Lecturer1, Location),
    course(Course, Time, Lecturer2, Location).

schedule_conflict(Time, Place, Course1, Course2):-
    course(Course1, Time, Lecturer, Place),
    course(Course2, Time, Lecturer, Place).
