(* Coursera Programming Languages, Homework 3, Provided Code *)

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

(* (_, 5) *) 
val ex1 = TupleP [Wildcard, ConstP 5]

(* SOME (x, 3) *)
val ex2 = ConstructorP ("SOME", TupleP [Variable "x", ConstP 3])

(* (s, (t, _)) is like: *)
val ex3 = TupleP [Variable "s", TupleP [Variable "t", Wildcard]]

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

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals str_lst =
    List.filter (fn x => Char.isUpper(String.sub(x, 0))) str_lst

fun longest_string1 str_lst =
    List.foldl (fn (x, y) => if String.size(x) > String.size(y)
			then x
			else y) "" str_lst

fun longest_string2 str_lst =
    List.foldl (fn (x, y) => if String.size(x) >= String.size(y)
			then x
			else y) "" str_lst

fun longest_string_helper f =
    List.foldl (fn (x, y) => if f (String.size(x), String.size(y))
			then x
			else y) ""

val longest_string3 = longest_string_helper (fn (x,y) => x > y)
val longest_string4 = longest_string_helper (fn (x,y) => x >= y)
val longest_capitalized = longest_string1 o only_capitals				     
val rev_string = String.implode o List.rev o String.explode

fun first_answer f lst =
    case lst of
	[] => raise NoAnswer
      | x::xs' => case (f x) of
		      NONE => first_answer f xs'
		    | SOME i => i

fun all_answers f lst =
    let
	val map_lst = List.map f lst
    in
	if List.all isSome map_lst
	then SOME (List.foldl (fn (x,y) => (valOf x) @ y) [] map_lst)
	else NONE
    end

fun count_wildcards p =
    let 
	val r = count_wildcards 
    in
	case p of
	    Wildcard          => 1
	  | Variable x        => 0
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end


fun count_wild_and_variable_lengths p =
    let 
	val r = count_wild_and_variable_lengths  
    in
	case p of
	    Wildcard          => 1
	  | Variable x        => (size x)
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

fun count_some_var sp =
    let 
	val s = #1 sp
	val p = #2 sp
	val r = count_some_var
    in
	case p of
	    Wildcard          => 0
	  | Variable x        => if x = s then 1 else 0
	  | TupleP ps         => List.foldl (fn (p,i) => (r (s,p)) + i) 0 ps
	  | ConstructorP(_,p) => r (s,p)
	  | _                 => 0
    end

fun check_pat p =
   true

fun match p =
    NONE

fun first_match u l =
    SOME []
