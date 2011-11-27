signature Type =
sig

  datatype Type = Int

  exception Error of string*(int*int)

  val checkProg : S100.Prog -> unit

  val getFuns : S100.Prog -> (string * (Type list * Type)) list
		          -> (string * (Type list * Type)) list

  val convertType : S100.Type -> Type
  val getType : S100.Type -> S100.Sid -> Type
  val getName : S100.Sid -> string

end
