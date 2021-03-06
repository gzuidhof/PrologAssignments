%For a more annotated version see report
isHittingSetTree(Tree):-
	Tree = node([],_);
	Tree = node([X],_), isHittingSetTree(X);
	Tree = node([H|T],_), isHittingSetTree(H), isHittingSetTree(T).

diagnoses(SD,OBS,COMPS,D):- hittingTree(SD,OBS,COMPS,[],CS),paths(CS,D).

conflictSet(SD,OBS,COMPS,HS,CS):- tp(SD,OBS,COMPS,HS,CS).

hittingTree(SD,OBS,COMPS,HS,Node):-
	not(conflictSet(SD,OBS,COMPS,HS,CS)), Node = node([],[]);
	conflictSet(SD,OBS,COMPS,HS,CS),
        CS = [H|T], hittingTree2([H|T], SD,OBS,COMPS,HS,Children), Node = node(Children, CS).

hittingTree2([X|XS],SD,OBS,COMPS,HS,Children) :-
	hittingTree(SD,OBS,COMPS,[X|HS],Child),
	hittingTree2(XS,SD,OBS,COMPS,HS,T), Children = [Child|T].
hittingTree2([],SD,OBS,COMPS,HS,Children) :- Children = [].

paths(node([],Path), Path).
paths(node([H],X), [X|P]) :- paths(H,P).
paths(node([H|T],X),[X|P]):- paths(H,P).

