
(* [3,4,5,6] *)
fun count (from : int, to : int) =
    if from=to
    then to::[]
    else from :: count(from+1, to)

fun countup_from1(x : int) =
    count(1,x)
	 

fun countup_from12(x : int) =
    let
	fun count (from : int, to : int) =
	    if from=to
	    then to::[]
	    else from :: count(from+1, to)
    in
	count(1,x)
    end

fun countup_from13(x : int) =
    let
	fun count (from : int) =
	    if from=x
	    then x::[]
	    else from :: count(from+1)
    in
	count(1)
    end
	
