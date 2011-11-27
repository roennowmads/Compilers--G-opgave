structure Interpreter :> Interpreter =
struct

  (* Use "raise Error (message,position)" for error messages *)
  exception Error of string*(int*int)

  type pos = int*int

  datatype value = Int of int | Bool of bool

  (* lookup function for symbol table as list of (name,value) pairs *)
  fun lookup x []
        = NONE
    | lookup x ((y,v)::table)
        = if x=y then SOME v else lookup x table

  (* combine two symbol tables and check for duplicates *)
  fun combineTables [] table2 p = table2
    | combineTables ((x,v)::table1) table2 p =
        case lookup x table2 of
          SOME _ => raise Error ("Repeated identifier "^x,p)
        | NONE => (x,v) :: combineTables table1 table2 p

  (* Match pattern to value and return SOME vtable or NONE *)
  fun matchPat pat value =
    case (pat,value) of
      (Cat.NumP (m,_), Int n) => if m=n then SOME [] else NONE
    | (Cat.VarP (x,p), _) => SOME [(x,value)]
    | _ => NONE

  (* evaluate expression *)
  fun evalExp exp vtable ftable =
    case exp of
      Cat.Num (n,pos) => Int n
    | Cat.Var (x,pos) =>
       (case lookup x vtable of
	  SOME v => v
        | _ => raise Error ("Unknown variable "^x,pos))
    | Cat.Plus (e1,e2,pos) =>
       (case (evalExp e1 vtable ftable,
              evalExp e2 vtable ftable) of
          (Int m,Int n) => Int (m+n)
        | _ => raise Error ("Non-int argument to +",pos))
    | Cat.Minus (e1,e2,pos) =>
       (case (evalExp e1 vtable ftable,
              evalExp e2 vtable ftable) of
          (Int m,Int n) => Int (m-n)
        | _ => raise Error ("Non-int argument to -",pos))
    | Cat.Apply (f,e1,pos) =>
       (case lookup f ftable of
	  SOME match =>
	    runMatch match (evalExp e1 vtable ftable) [] ftable pos
        | _ => raise Error ("Unknown function "^f,pos))
    | Cat.Read pos =>
        (case Int.fromString (TextIO.inputLine TextIO.stdIn) of
	   SOME m => Int m
	 | NONE => raise Error ("Read error",pos))
    | Cat.Write (e1,pos) =>
       (case evalExp e1 vtable ftable of
          Int m =>
	    (TextIO.output (TextIO.stdOut, Int.toString m ^"\n");
	     Int m)
        | _ => raise Error ("Non-int argument to write",pos))

  and runMatch ((p,e)::ms) v vtable ftable pos =
        (case matchPat p v of
	   SOME vtable1 => evalExp e (vtable1 @ vtable) ftable
	 | NONE => runMatch ms v vtable ftable pos)
    | runMatch [] v vtable ftable pos =
        raise Error ("No matching pattern",pos)

  fun getFunDecs [] ftable = ftable
    | getFunDecs ((f, targ, tresult, m, pos)::fs) ftable =
        if List.exists (fn (g,_)=>f=g) ftable
	then raise Error ("Duplicate declaration of function "^f,pos)
        else getFunDecs fs ((f, m) :: ftable)

  fun runProgram (tyDecs, funDecs, e) =
    let
      val ftable = getFunDecs funDecs []
    in
      (evalExp e [] ftable; ())
    end
end
