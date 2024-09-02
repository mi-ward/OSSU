use "homework1.sml";

val date_list = [ (1900,1,1),
		  (1902,3,10),
		  (1905,4,11),
		  (1910,4,12),
		  (1922,3,22),
		  (1941,12,10),
		  (1942,11,11),
		  (2000,3,25)]

(*1*) val  true_test_1 = is_older((1988,3,25),(1989,5,24)) = true;
(*1*) val equal_test_1 = is_older((1988,3,25),(1988,3,25)) = false;
(*1*) val false_test_1 = is_older((1989,5,24),(1988,3,25)) = false;
(*2*) val  zero_test_2 = number_in_month([(1900,1,1),(1901,2,1),(1902,4,30)], 3) = 0;
(*2*) val   one_test_2 = number_in_month([(1900,1,1),(1901,2,1),(1902,3, 1)], 3) = 1;
(*2*) val   all_test_2 = number_in_month([(1900,1,1),(1900,1,2),(1900,1, 3)], 1) = 3;
(*3*) val  zero_test_3 = number_in_months(date_list, [2,5,6,7,8,9,10]) = 0;
(*3*) val   one_test_3 = number_in_months(date_list, [11]) = 1;
(*3*) val   all_test_3 = number_in_months(date_list, [1,3,4,11,12]) = 8;
(*4*) val  zero_test_4 = dates_in_month(date_list, 8) = [];
(*4*) val  one_test_4 = dates_in_month(date_list, 3) = [(1902,3,10),
							(1922,3,22),
							(2000,3,25)];
(*5*) val zero_test_5 = dates_in_months(date_list, [2,5,6,7,8,9,10]) = [];
(*5*) val  all_test_5 = dates_in_months(date_list, [1,3,4,11,12]) = [(1900,1,1),
								     (1902,3,10),
								     (1922,3,22),
								     (2000,3,25),
								     (1905,4,11),
								     (1910,4,12),
								     (1942,11,11),
								     (1941,12,10)];

(*6*) val first_test_6 = get_nth(["a","b","c","d","e"], 1) = "a"
(*6*) val  last_test_6 = get_nth(["a","b","c","d","e"], 5) = "e"

(*12*) val one_test_12 = number_in_months_challenge([(1900,1,1),(1901,2,1),(1902,4,30)], [2,2,2]) = 1
(*12*) val nim_all_test_12 = number_in_months_challenge(date_list, [1,3,1,3,4,11,3,12]) = 8;
(*12*) val dim_all_test_12 = dates_in_months_challenge(date_list, [1,1,3,1,4,11,3,12,11]) = [(1900,1,1),
										   (1902,3,10),
										   (1922,3,22),
										   (2000,3,25),
										   (1905,4,11),
										   (1910,4,12),
										   (1942,11,11),
										   (1941,12,10)];

	
    
