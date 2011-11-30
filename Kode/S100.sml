structure  S100 =
struct

  (* types for abstract syntax for 100 *)

  type pos = int * int  (* position: (line, column) *)

  datatype Type
    = Int of pos
    | Char of pos 

  datatype Sid
    = Val of string * pos
(*    | Ref of string * pos *)

  type Dec = Type * Sid list

  datatype Exp
    = NumConst of int * pos
(*    | CharConst of char * pos *)
(*    | StringConst of string * pos *)
    | LV of Lval
    | Assign of Lval * Exp * pos
    | Plus of Exp * Exp * pos
    | Minus of Exp * Exp * pos
(*    | Equal of Exp * Exp * pos *)
    | Less of Exp * Exp * pos
    | Call of string * Exp list * pos

  and Lval
    = Var of string * pos
(*    | Deref of string * pos *)
(*    | Lookup of string * Exp * pos *)

  datatype Stat
    = EX of Exp
    | If of Exp * Stat * pos
    | IfElse of Exp * Stat * Stat * pos
(*    | While of Exp * Stat * pos *)
    | Return of Exp * pos
(*    | Block of Dec list * Stat list * pos *)

  type FunDec = Type * Sid * Dec list * Stat * pos

  type Prog = FunDec list

end
