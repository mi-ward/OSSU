(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(* String List -> SOME List or NONE *)
(* fun all_except_option (s, str_list)  =
    let fun remove_from_list(str_list) =
	    case str_list of
		[] => []
	      | str::str_list' => if same_string(s, str)
				  then str_list'
				  else str::remove_from_list(str_list')
    in case str_list of
		[] => NONE
	      | str::str_list' => if same_string(s,str)
				  then SOME (remove_from_list(str_list))
				  else all_except_option(s, str_list') end *)
				      
fun all_except_option (s, str_list)  =
    let fun remove_from_list(str_list) =
	    case str_list of
		[] => []
	      | str::str_list' => if same_string(s,str)
				  then remove_from_list(str_list')
				  else str::remove_from_list(str_list')
	fun len(lst) =
	    case lst of
		[] => 0
	      | x::lst' => 1 + len(lst') 
	val removed = remove_from_list(str_list)
    in	if (len str_list) = (len removed) then NONE else SOME removed end 

fun get_substitutions1 (lolos, str) =
    case lolos of
	[] => []
      | x::xs' => let val los =  all_except_option(str, x)
		  in case los of
			 NONE => get_substitutions1(xs', str)
		       | SOME los => los @ get_substitutions1(xs', str) end

fun get_substitutions2 (lolos, str) =
    let fun aux(lolos,str,acc) =  
	    case lolos of
		[] => acc
	      | x::xs' => let val los =  all_except_option(str, x)
			  in case los of
				 NONE => aux(xs', str, acc)
			       | SOME los => aux(xs', str, (acc @ los)) end
    in aux(lolos, str, [])
    end

fun similar_names (lolos, full_name) =
    let fun get_fname {first=f,middle=m,last=l} = f
	val f_name = get_fname(full_name)
	val possible_f_names = f_name :: get_substitutions2(lolos, f_name)
	fun generate_full_names (possible_f_names, {first=f,middle=m,last=l}) =
	    case possible_f_names of
		[] => []
	      | x::xs => {first=x,middle=m,last=l}::generate_full_names(xs, full_name)
    in
	generate_full_names(possible_f_names, full_name)
    end

fun card_color(card) =
    case card of
	(Clubs,_)    => Black
      | (Spades,_)   => Black
      | (Hearts,_)   => Red
      | (Diamonds,_) => Red

fun card_value(card) =
    case card of
	(_,Ace)   => 11
     |  (_,King)  => 10
     |  (_,Queen) => 10
     |  (_,Jack)  => 10 
     |  (_,Num i) => i
			 		 
fun remove_card(cs,c,e) =
    let fun remove_card_aux(cs,c,e,acc) =
	    case cs of
		[] => raise e
	      | x::xs => if c = x
			 then acc @ xs
			 else remove_card_aux(xs,c,e, x::acc)
    in
	remove_card_aux(cs,c,e,[])
    end

fun all_same_color(loc) =
    case loc of
	[] => true
	   | c1::[] => true 
	   | c1::c2::rest => (card_color(c1) = card_color(c2)) andalso
			     all_same_color(c2::rest)

fun sum_cards(loc) =
    let fun sum_card_aux(loc, acc) =
	    case loc of
		[] => acc
	      | c::cs' => sum_card_aux(cs', (card_value(c) + acc))
    in
	sum_card_aux(loc,0)
    end

fun score(loc, goal) =
    let
	val sum = sum_cards(loc)
	val same_color = all_same_color(loc)
	val prelim_score = if sum > goal
			   then 3 * (sum - goal)
			   else (goal - sum)
    in
	if same_color
	then prelim_score div 2
	else prelim_score
    end

fun officiate(loc, lom, goal) =
    let
	fun officiate_aux(loc, lom, goal, held_cards) =
	    if sum_cards(held_cards) > goal
	    then score(held_cards,goal)
	    else
		case lom of
		    [] => score(held_cards, goal)
		  | move::lom' => case move of
				      Discard c => officiate_aux(loc, lom', goal, remove_card(held_cards,c,IllegalMove))
				    | Draw => case loc of
						  [] => score(held_cards, goal)
						| card::loc' => officiate_aux(loc',lom',goal,card::held_cards)
    in officiate_aux(loc,lom,goal,[]) end


