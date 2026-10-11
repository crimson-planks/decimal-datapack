# arguments (scoreboard): (divpow10_n decimal_in), (divpow10_divval decimal_in)
# output (scoreboard, also return value): divpow10_n

execute if score divpow10_divval decimal_in matches 0 run return fail

scoreboard players operation ndiv decimal_tmp = divpow10_n decimal_in
scoreboard players operation ndiv decimal_tmp /= divpow10_divval decimal_in

scoreboard players operation r decimal_tmp = divpow10_n decimal_in
scoreboard players operation r decimal_tmp %= divpow10_divval decimal_in
# %= is floored division, so do r=-(r-divval) and also add 1 to ndiv if m is negative and if r != 0 
execute if score divpow10_n decimal_in matches ..-1 if score r decimal_tmp matches 1.. run scoreboard players operation r decimal_tmp -= divpow10_divval decimal_in
execute if score divpow10_n decimal_in matches ..-1 if score r decimal_tmp matches 1.. run scoreboard players operation r decimal_tmp *= -1 decimal_const
execute if score divpow10_n decimal_in matches ..-1 if score r decimal_tmp matches 1.. run scoreboard players add ndiv decimal_tmp 1
#tellraw @a [{"text":"r: "},{"score":{name:"r",objective:"decimal_tmp"}}]
# if last digit(r) is half of divval and ndiv is even, add 1 to ndiv (or subtract 1 if negative)
scoreboard players operation half_divval decimal_tmp = divpow10_divval decimal_in
scoreboard players operation half_divval decimal_tmp /= 2 decimal_const
scoreboard players operation divvalmod2 decimal_tmp = divpow10_divval decimal_in
scoreboard players operation divvalmod2 decimal_tmp %= 2 decimal_const
execute if score r decimal_tmp = half_divval decimal_tmp if score divvalmod2 decimal_tmp matches 0 run scoreboard players operation ndivmod2 decimal_tmp = ndiv decimal_tmp
execute if score r decimal_tmp = half_divval decimal_tmp if score divvalmod2 decimal_tmp matches 0 run scoreboard players operation ndivmod2 decimal_tmp %= 2 decimal_const
#tellraw @a [{"text":"ndivmod2: "},{"score":{name:"ndivmod2",objective:"decimal_tmp"}}]
execute if score r decimal_tmp = half_divval decimal_tmp if score ndivmod2 decimal_tmp matches 1 if score ndiv decimal_tmp matches 0.. run scoreboard players add ndiv decimal_tmp 1
execute if score r decimal_tmp = half_divval decimal_tmp if score ndivmod2 decimal_tmp matches 1 if score ndiv decimal_tmp matches ..-1 run scoreboard players remove ndiv decimal_tmp 1
# if last digit(r) > half of divval, add 1 to ndiv (or subtract 1 if negative)
execute if score r decimal_tmp > half_divval decimal_tmp if score ndiv decimal_tmp matches 0.. run scoreboard players add ndiv decimal_tmp 1
execute if score r decimal_tmp > half_divval decimal_tmp if score ndiv decimal_tmp matches ..-1 run scoreboard players remove ndiv decimal_tmp 1

#TODO: overflow
scoreboard players operation divpow10_n decimal_out = ndiv decimal_tmp
return run scoreboard players get divpow10_n decimal_out