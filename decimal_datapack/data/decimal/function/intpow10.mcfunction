#arguments (scoreboard): (intpow10 decimal_in)
#output (return value)
execute if score intpow10 decimal_in matches ..-1 run return 0
execute if score intpow10 decimal_in matches 0 run return 1
execute if score intpow10 decimal_in matches 1 run return 10
execute if score intpow10 decimal_in matches 2 run return 100
execute if score intpow10 decimal_in matches 3 run return 1000
execute if score intpow10 decimal_in matches 4 run return 10000
execute if score intpow10 decimal_in matches 5 run return 100000
execute if score intpow10 decimal_in matches 6 run return 1000000
execute if score intpow10 decimal_in matches 7 run return 10000000
execute if score intpow10 decimal_in matches 8 run return 100000000
execute if score intpow10 decimal_in matches 9 run return 1000000000
return fail
