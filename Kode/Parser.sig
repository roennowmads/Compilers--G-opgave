local
type t__1__ = (int*int)
type t__2__ = (int*int)
type t__3__ = (int*int)
type t__4__ = (int*int)
type t__5__ = string*(int*int)
type t__6__ = (int*int)
type t__7__ = (int*int)
type t__8__ = (int*int)
type t__9__ = (int*int)
type t__10__ = (int*int)
type t__11__ = int*(int*int)
type t__12__ = (int*int)
type t__13__ = (int*int)
type t__14__ = (int*int)
type t__15__ = (int*int)
type t__16__ = (int*int)
in
datatype token =
    ASSIGN of t__1__
  | COMMA of t__2__
  | ELSE of t__3__
  | EOF of t__4__
  | ID of t__5__
  | IF of t__6__
  | INT of t__7__
  | LESS of t__8__
  | LPAR of t__9__
  | MINUS of t__10__
  | NUM of t__11__
  | PLUS of t__12__
  | RETURN of t__13__
  | RPAR of t__14__
  | SEMICOLON of t__15__
  | THEN of t__16__
end;

val Prog :
  (Lexing.lexbuf -> token) -> Lexing.lexbuf -> S100.Prog;
