local open Obj Lexing in


 open Lexing;

 exception LexicalError of string * (int * int) (* (message, (line, column)) *)

 val currentLine = ref 1
 val lineStartPos = ref [0]

 fun getPos lexbuf = getLineCol (getLexemeStart lexbuf)
				(!currentLine)
				(!lineStartPos)

 and getLineCol pos line (p1::ps) =
       if pos>=p1 then (line, pos-p1)
       else getLineCol pos (line-1) ps
   | getLineCol pos line [] = raise LexicalError ("",(0,0))

 fun lexerError lexbuf s = 
     raise LexicalError (s, getPos lexbuf)

 fun keyword (s, pos) =
     case s of
         "if"           => Parser.IF pos
       | "then"         => Parser.THEN pos
       | "else"         => Parser.ELSE pos
       | "int"          => Parser.INT pos
	   (*| "char"         => Parser.CHAR pos 
	   | "string"       => Parser.STRING pos *)
       | "return"       => Parser.RETURN pos
	   (* | "while" 		=> Parser.WHILE pos *)
       | _              => Parser.ID (s, pos)

 
fun action_14 lexbuf = (
 lexerError lexbuf "Illegal symbol in input" )
and action_13 lexbuf = (
 Parser.EOF (getPos lexbuf) )
and action_12 lexbuf = (
 Parser.SEMICOLON (getPos lexbuf) )
and action_11 lexbuf = (
 Parser.COMMA (getPos lexbuf) )
and action_10 lexbuf = (
 Parser.RPAR (getPos lexbuf) )
and action_9 lexbuf = (
 Parser.LPAR (getPos lexbuf) )
and action_8 lexbuf = (
 Parser.ASSIGN (getPos lexbuf) )
and action_7 lexbuf = (
 Parser.LESS (getPos lexbuf) )
and action_6 lexbuf = (
 Parser.MINUS (getPos lexbuf) )
and action_5 lexbuf = (
 Parser.PLUS (getPos lexbuf) )
and action_4 lexbuf = (
 keyword (getLexeme lexbuf,getPos lexbuf) )
and action_3 lexbuf = (
 case Int.fromString (getLexeme lexbuf) of
                               NONE   => lexerError lexbuf "Bad integer"
                             | SOME i => Parser.NUM (i, getPos lexbuf) )
and action_2 lexbuf = (
 currentLine := !currentLine+1;
                          lineStartPos :=  getLexemeStart lexbuf
			                   :: !lineStartPos;
                          Token lexbuf )
and action_1 lexbuf = (
 Token lexbuf )
and action_0 lexbuf = (
 Token lexbuf )
and state_0 lexbuf = (
 let val currChar = getNextChar lexbuf in
 if currChar >= #"A" andalso currChar <= #"Z" then  state_15 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_15 lexbuf
 else if currChar >= #"0" andalso currChar <= #"9" then  state_11 lexbuf
 else case currChar of
    #"\t" => state_3 lexbuf
 |  #"\r" => state_3 lexbuf
 |  #" " => state_3 lexbuf
 |  #"\n" => action_2 lexbuf
 |  #"\f" => action_2 lexbuf
 |  #"=" => action_8 lexbuf
 |  #"<" => action_7 lexbuf
 |  #";" => action_12 lexbuf
 |  #"/" => state_10 lexbuf
 |  #"-" => action_6 lexbuf
 |  #"," => action_11 lexbuf
 |  #"+" => action_5 lexbuf
 |  #")" => action_10 lexbuf
 |  #"(" => action_9 lexbuf
 |  #"\^@" => action_13 lexbuf
 |  _ => action_14 lexbuf
 end)
and state_3 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_0);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\t" => state_21 lexbuf
 |  #"\r" => state_21 lexbuf
 |  #" " => state_21 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_10 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_14);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"*" => state_18 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_11 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_3);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_17 lexbuf
 else backtrack lexbuf
 end)
and state_15 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_4);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_16 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_16 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_16 lexbuf
 else case currChar of
    #"_" => state_16 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_16 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_4);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_16 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_16 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_16 lexbuf
 else case currChar of
    #"_" => state_16 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_17 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_3);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_17 lexbuf
 else backtrack lexbuf
 end)
and state_18 lexbuf = (
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"*" => state_19 lexbuf
 |  #"\^@" => backtrack lexbuf
 |  _ => state_18 lexbuf
 end)
and state_19 lexbuf = (
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"/" => action_1 lexbuf
 |  #"\^@" => backtrack lexbuf
 |  _ => state_18 lexbuf
 end)
and state_21 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_0);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\t" => state_21 lexbuf
 |  #"\r" => state_21 lexbuf
 |  #" " => state_21 lexbuf
 |  _ => backtrack lexbuf
 end)
and Token lexbuf =
  (setLexLastAction lexbuf (magic dummyAction);
   setLexStartPos lexbuf (getLexCurrPos lexbuf);
   state_0 lexbuf)

(* The following checks type consistency of actions *)
val _ = fn _ => [action_14, action_13, action_12, action_11, action_10, action_9, action_8, action_7, action_6, action_5, action_4, action_3, action_2, action_1, action_0];

end
