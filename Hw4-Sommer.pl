%  Author: Steven Sommer
%  Course: CS 415 - Principles of Programming Languages
%  Assignment Name: Prolog Program
%  Description: A Boolean expression is of the form – in Prolog List
%              [and, a, b, c, d]   or         or [and, [or, b, c], [not, a], [and, c, d]] – or any combination thereof 
%              – a,b,c,d are propositions.
%              Truth set is given in the form – in Prolog List
%                     [[a, t], [b, f], [c, t], [d, t]]     where a is true, b is false, c is true and d is true.
%
%   Write Prolog predicate evalb – which takes in a Boolean expression as described above, 
%   and a (sufficient) truth set as described above, and binds the value of the evaluated Boolean expression to the last parameter.

 
evalb(Expr, TruthSet, Result) :- atom(Expr), member((Expr, Result), TruthSet).
evalb([and|Expr], TruthSet, Result) :-maplist(evalb, Expr, [TruthSet|_]),Result = true.
evalb([or|Expr], TruthSet, Result) :-maplist(evalb, Expr, [TruthSet|_]),member(Result, [true, false]).
evalb([not|Expr], TruthSet, Result) :-evalb(Expr, TruthSet, SubResult),Result is 1 - SubResult.
