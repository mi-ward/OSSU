fun is_older(date1 : int*int*int, date2 : int*int*int) =
    let val year_is_less  = (#1 date1) < (#1 date2)
	val month_is_less = (#2 date1) < (#2 date2)
	val day_is_less   = (#3 date1) < (#3 date2)
	val year_is_equal  = (#1 date1) = (#1 date2)
	val month_is_equal  = (#2 date1) = (#2 date2)
					     
    in
	if year_is_equal
	then
	    if month_is_equal
	    then day_is_less
	    else month_is_less
	else	
	    if year_is_less
	    then year_is_less
	    else
		if month_is_less
		then (year_is_less andalso month_is_less)
		else
		    if day_is_less
		    then (year_is_less andalso month_is_less andalso day_is_less)
		    else false
    end

fun number_in_month(date_list : (int*int*int) list, month : int) =
    if null date_list
    then 0
    else
	if (#2 (hd date_list)) = month
	then 1 + number_in_month((tl date_list), month)
	else number_in_month((tl date_list), month)
		   
fun number_in_months(date_list : (int*int*int) list, month_list : int list) =
    if null month_list
    then 0
    else
	number_in_month(date_list, (hd month_list)) +
	number_in_months(date_list, (tl month_list))


fun dates_in_month(date_list : (int*int*int) list, month : int) =
    if null date_list
    then []
    else
	if (#2 (hd date_list)) = month
	then (hd date_list) :: dates_in_month((tl date_list), month)
	else dates_in_month((tl date_list), month)

fun dates_in_months(date_list : (int*int*int) list, month_list : int list) =
    if null month_list
    then []
    else
	dates_in_month(date_list, (hd month_list)) @
	dates_in_months(date_list, (tl month_list))

fun get_nth(string_list : string list, n : int) =
    if n = 1
    then (hd string_list)
    else get_nth((tl string_list), n-1)

fun date_to_string(date : int*int*int) =
    let
	val month_list = ["January","February","March","April","May","June","July","August","September","October","November","December"]
	val month = get_nth(month_list, (#2 date))
	val day = Int.toString(#3 date)
	val year = Int.toString(#1 date)
    in
	month ^ " " ^ day ^ ", " ^ year
    end

fun number_before_reaching_sum(sum : int, lst : int list) =
    let
	fun add_and_accrue(lst : int list, total : int , idx : int) =
	    if (total + (hd lst))  >= sum
	    then idx
	    else add_and_accrue((tl lst), (total + (hd lst)), (idx + 1))
    in
	add_and_accrue(lst, 0, 0)
    end

fun what_month(day : int) =
    let
	val days_in_months = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
	number_before_reaching_sum(day, days_in_months) + 1
    end

fun month_range(day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month(day1)::month_range((day1+1),day2)


fun oldest(list_of_dates : (int*int*int) list) =
    if null list_of_dates
    then NONE
    else
	let
	    fun date_compare(date : int*int*int, list_of_date : (int*int*int) list) =
		if null list_of_date
		then SOME date
		else
		    if is_older(date, (hd list_of_date))
		    then date_compare(date, (tl list_of_date))
		    else date_compare((hd list_of_date), (tl list_of_date))
	in
	    date_compare((hd list_of_dates), (tl list_of_dates))
	end

fun number_in_months_challenge(date_list : (int*int*int) list, month_list : int list) =
    let
	fun remove_from_list(n : int, lst : int list) =
	    if null lst
	    then []
	    else
		if n = (hd lst)
		then remove_from_list(n, (tl lst))
		else (hd lst) :: remove_from_list(n, (tl lst))
			 
	fun remove_duplicates(lst : int list) =
	    if null lst
	    then []
	    else
		(hd lst) :: remove_duplicates(remove_from_list((hd lst), (tl lst)))
    in
	number_in_months(date_list, remove_duplicates(month_list))
    end
	    
fun dates_in_months_challenge(date_list : (int*int*int) list, month_list : int list) =
    let
	fun remove_from_list(n : int, lst : int list) =
	    if null lst
	    then []
	    else
		if n = (hd lst)
		then remove_from_list(n, (tl lst))
		else (hd lst) :: remove_from_list(n, (tl lst))
			 
	fun remove_duplicates(lst : int list) =
	    if null lst
	    then []
	    else
		(hd lst) :: remove_duplicates(remove_from_list((hd lst), (tl lst)))
    in
	dates_in_months(date_list, remove_duplicates(month_list))
    end

fun reasonable_date(date : int*int*int) =
    let
	val  year = (#1 date)
	val month = (#2 date)
	val   day = (#3 date)
	val days_in_months = [31,28,31,30,31,30,31,31,30,31,30,31]
	fun days_in_month(month : int, days : int list) =
	    if month = 1
	    then (hd days)
	    else days_in_month((month-1), (tl days))
	fun reasonable_year() = (year > 0)
	fun reasonable_month() = (month >= 1) andalso (month <= 12)
	fun reasonable_day() = (day >= 1) andalso
			       (day <= days_in_month(month, days_in_months))
	fun leap_year_check() =
	    (month =  2) andalso
	    (day   = 29) andalso 
	    ((year mod 400) = 0 orelse (((year mod   4) =  0)
				       andalso
				       ((year mod 100) <> 0)))
    in
	leap_year_check() orelse
	(reasonable_year()  andalso
	 reasonable_month() andalso
	 reasonable_day())
    end
	   
					  
		
		
	      
	

		
