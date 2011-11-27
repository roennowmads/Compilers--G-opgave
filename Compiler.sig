signature Compiler =
sig

  exception Error of string*(int*int)

  val compile : S100.Prog -> Mips.mips list

end
