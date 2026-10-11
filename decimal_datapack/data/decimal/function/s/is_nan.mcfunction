# arguments(scoreboard): (in_is_nan decimal_m), (in_is_nan decimal_e)
# output (scoreboard, return): 0 or 1 (is_nan decimal_out)
scoreboard players set is_nan decimal_out 0
execute unless score in_is_nan decimal_e = int32_max decimal_const run return 0
execute if score in_is_nan decimal_m = int32_min decimal_const run return 0
execute if score in_is_nan decimal_m = int32_max decimal_const run return 0
execute if score in_is_nan decimal_m matches -999999999..999999999 run return 0
scoreboard players set is_nan decimal_out 1
return 1