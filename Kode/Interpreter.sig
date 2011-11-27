signature Interpreter =
sig

  exception Error of string*(int*int)

  val runProgram : Cat.Prog -> unit

end
