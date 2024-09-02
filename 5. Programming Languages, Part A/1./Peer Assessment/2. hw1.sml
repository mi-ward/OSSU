fun is_older (first : int*int*int, second : int*int*int) =
    if (#1 first) <> (#1 second)
    then (#1 first) < (#1 second)
    else if (# 2 first) <> (#2 second)
    then (#2 first) < (#2 second)
    else (#3 first) < (#3 second)
			  
fun number_in_month (dates : (int*int*int) list, month : int) =
    let
	fun number_in_month_dates_only (dates : (int*int*int) list) =
	    if null dates
	    then 0
	    else
		let val tl_dates = number_in_month_dates_only (tl dates)
		in
		    if (#2 (hd dates)) = month
		    then 1 + tl_dates
		    else tl_dates
		end
    in
	number_in_month_dates_only (dates)
    end

fun number_in_months (dates : (int*int*int) list, months : int list) =
    if null months
    then 0
    else number_in_month (dates, hd months) + number_in_months (dates, tl months)

fun dates_in_month (dates : (int*int*int) list, month : int) =
    let
	fun dates_in_month_dates_only (dates : (int*int*int) list) =
	    if null dates
	    then []
	    else
		let
		    val hd_date = hd dates
		    val tl_dates = dates_in_month_dates_only (tl dates)
		in
		    if #2 hd_date = month
		    then hd_date::tl_dates
		    else tl_dates
		end
    in
	dates_in_month_dates_only (dates)
    end

fun dates_in_months (dates : (int*int*int) list, months : int list) =
    if null months
    then []
    else dates_in_month (dates, hd months) @ dates_in_months (dates, tl months)

fun get_nth (strings : string list, n : int) =
    if n <= 1
    then hd strings
    else get_nth(tl strings, n - 1)


fun date_to_string (date : int*int*int) =
    let
	val month_strings = ["January", "February", "March", "April", "May", "June", "July",
			     "August", "September", "October", "November", "December"]
    in
	get_nth (month_strings, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end
										      
fun number_before_reaching_sum (sum : int, list : int list) =
    let	val sum_rest = sum - (hd list)
    in
	if sum_rest > 0
	then 1 + number_before_reaching_sum (sum_rest, tl list)
	else 0
    end

fun what_month (day : int) =
    let val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
	1 + number_before_reaching_sum (day, months)
    end

fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month(day1)::month_range(day1+1, day2)

fun oldest (dates : (int*int*int) list) =
    if null dates
    then NONE
    else
	let
	    val hd_date = hd dates
	    val tl_dates = oldest (tl dates)
	in
	    if isSome tl_dates andalso is_older (valOf tl_dates, hd_date)
	    then tl_dates
	    else SOME (hd_date)
	end

fun reasonable_date (date: int*int*int) =
    let
	val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	fun get_nth_int (list : int list, n : int) =
	    if n <= 1
	    then hd list
	    else get_nth_int(tl list, n - 1)
	fun days_in_month () =
	    if #2 date < 1 orelse #2 date > 12
	    then 0
	    else if #2 date = 2 andalso (#1 date) mod 4 = 0
	    then 1 + get_nth_int (months, #2 date)
	    else get_nth_int (months, #2 date)
    in
	#1 date > 0 andalso (#2 date >= 1 andalso #2 date <= 12) andalso (#3 date >= 1 andalso #3 date <= days_in_month())
    end


	
