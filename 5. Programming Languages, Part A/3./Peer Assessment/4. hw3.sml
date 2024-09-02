exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

val only_capitals = List.filter (fn x => Char.isUpper (String.sub(x, 0)))

val longest_string1 = foldl(fn (item, acc) => if String.size(item) > String.size(acc) then item else acc) ""

val longest_string2 = foldl(fn (item, acc) => if String.size(item) >= String.size(acc) then item else acc) ""

fun longest_string_helper f = foldl(fn (item, acc) => if f(String.size(item), String.size(acc)) then item else acc) ""

val longest_string3 = longest_string_helper (fn (item_size, acc_size) => item_size > acc_size)

val longest_string4 = longest_string_helper (fn (item_size, acc_size) => item_size >= acc_size)
					    
val longest_capitalized = longest_string1 o only_capitals
					    
val rev_string = implode o rev o explode
						    
fun first_answer f xs = case xs of
			    [] => raise NoAnswer
			  | x::xs' => case f(x) of
					 SOME y => y
				       | NONE => first_answer f xs'
							      								   
fun all_answers f xs =
    let fun aux(xs, acc) =
	    case xs of
		[] => SOME acc
	      | x::xs' => case f(x) of
			      SOME y => aux(xs', acc @ y)
			    | NONE => NONE
    in aux(xs, [])
    end
	
val count_wildcards = g (fn () => 1) (fn _ => 0)

val count_wild_and_variable_lengths = g (fn () => 1) (fn s => String.size s)

fun count_some_var (s, p) = g (fn () => 0) (fn s' => if s = s' then 1 else 0) p				

fun check_pat p =
    let fun all_variable_strings p =
	    case p of
		Variable x => [x]
	     |  ConstructorP(_, p) =>  all_variable_strings p
	     | TupleP ps => foldl(fn (item, acc) => acc @ all_variable_strings item) [] ps
	     | _ => []
								    
	fun all_uniques strings =
	    case strings of
		[] => true
	      | s::strings' => if List.exists (fn s' => s = s') strings'
			       then false
			       else all_uniques strings'
    in (all_uniques o all_variable_strings) p
    end
					     
fun match (valu, pattern) =
    case (valu, pattern) of
	(_, Wildcard) => SOME []							  
      | (v, Variable s) => SOME [(s, v)]
      | (Unit, UnitP) => SOME []
      | (Const x, ConstP y) => if x = y
			       then SOME []
			       else NONE
      | (Tuple vs, TupleP ps) => (all_answers match (ListPair.zipEq(vs, ps))
				  handle UnequalLengths => NONE)
      | (Constructor(s2, v), ConstructorP(s1, p)) => if s1 = s2
						    then match (v, p)
						    else NONE
      | _ => NONE

		 
fun first_match valu patterns =
    SOME (first_answer (fn pattern => match (valu, pattern)) patterns)
    handle NoAnswer => NONE

			   
