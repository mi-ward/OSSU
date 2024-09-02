fun is_older(date1 : (int * int * int), date2 : (int * int * int)) = 
    if (#1 date1) - (#1 date2) < 0
    then true
    else 
        if (#1 date1) - (#1 date2) = 0
        then 
            if (#2 date1) - (#2 date2) < 0
            then true
            else 
                if (#2 date1) - (#2 date2) = 0
                then 
                    if (#3 date1) - (#3 date2) < 0
                    then true
                    else false
                else false
        else false;

fun number_in_month(date : (int * int * int) list, month : int) = 
    if null date
    then 0
    else 
        if #2 (hd date) = month
        then 1 + number_in_month(tl date, month)
        else 0 + number_in_month(tl date, month);

fun number_in_months(date : (int * int * int) list, month : int list) = 
    if null month
    then 0
    else
        number_in_month(date, hd month) + number_in_months(date, tl month);

fun dates_in_month(date : (int * int * int) list, month : int) =
    if null date
    then []
    else 
        if #2 (hd date) = month
        then (hd date)::dates_in_month(tl date, month)
        else dates_in_month(tl date, month);

fun dates_in_months(date : (int * int * int) list, month : int list) = 
    let
        fun append(xs: (int * int * int) list, ys: (int * int * int) list) =
            if null xs
            then ys
            else (hd xs)::append(tl xs, ys)
    in
        if null month
        then []
        else 
            append(dates_in_month(date, hd month),dates_in_months(date, tl month))
    end;

fun get_nth(strList: string list, n: int) = 
    if null strList
    then ""
    else 
        if n = 1
        then hd strList
        else get_nth(tl strList, n-1);

fun date_to_string(date: (int * int * int)) = 
    let val strMonth = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in 
        get_nth(strMonth, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

fun number_before_reaching_sum(sum: int, num : int list) = 
    let
        fun helper(total: int, index: int, numList: int list) = 
            if total >= sum
            then index - 1
            else helper(total + (hd numList), index + 1, (tl numList))
    in helper(0, 0, num)
    end

fun what_month(day: int) =
    let val daysOfMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        1 + number_before_reaching_sum(day, daysOfMonth)
    end

fun month_range(day1: int, day2: int) =
    if day1 > day2
    then []
    else what_month(day1)::month_range(day1+1,day2)

fun oldest(dates: (int * int * int) list) = 
    if null dates
    then NONE
    else 
        let fun helper(oldDate: (int * int * int), dates1: (int * int * int) list) =
                if null dates1 then oldDate
                else
                    if is_older(oldDate, hd dates1)
                    then helper(oldDate, tl dates1)
                    else helper(hd dates1, tl dates1)
        in
            SOME (helper(hd dates, tl dates))
        end

fun remove_duplicates(n: int list) = 
    let fun is_in(item: int, alist: int list) = 
            if null alist then false
            else 
                if hd alist = item
                then true
                else is_in(item, tl alist)
    in
        if null n then n
        else 
            if is_in(hd n, tl n)
            then remove_duplicates(tl n)
            else hd n :: remove_duplicates(tl n)
    end

fun number_in_months_challenge(date : (int * int * int) list, month : int list) = 
    number_in_months(date, remove_duplicates(month));

fun dates_in_months_challenge(date : (int * int * int) list, month : int list) = 
    dates_in_months(date, remove_duplicates(month));

fun reasonable_date(date: (int * int * int)) =
    if (#1 date <= 0) orelse (#2 date <= 0 andalso #2 date > 12) orelse (#3 date <= 0)  
    then false
    else 
        let 
            val month30 = [4,6,9,11]
            val month31 = [1,3,5,7,8,10,12]
            fun is_in(item: int, alist: int list) = 
                if null alist then false
                else 
                    if hd alist = item
                    then true
                    else is_in(item, tl alist)
        in 
            if is_in(#2 date,month30) andalso #3 date >30 then false
            else 
                if is_in(#2 date, month31) andalso #3 date > 31 then false
                else 
                    if #2 date = 2 andalso #1 date mod 100 <> 0 andalso (#1 date mod 400 = 0 orelse #1 date mod 4 = 0) andalso #3 date <= 29 then true
                    else 
                        if #2 date = 2 andalso #3 date <= 28 then true
                        else false
        end

