s = 'akjbnvrasldkjfhkljfhasbkjekjrbhjhkfbabcdefgsaalbrkjhr'
longest_substring_alpha = ""
for start_win in range(0, len(s)):
    temp_substring = start_win_alpha = s[start_win]
    end_win_alpha = ""
    for end_win in range((start_win+1), len(s)):
        end_win_alpha = s[end_win]
        if temp_substring[-1] <= end_win_alpha: temp_substring += end_win_alpha
        if len(temp_substring) > len(longest_substring_alpha): longest_substring_alpha = temp_substring
        if temp_substring[-1] > end_win_alpha: break
print(longest_substring_alpha)

    





            