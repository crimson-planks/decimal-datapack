# arguments(scoreboard): (in_neg decimal_m), (in_neg decimal_m)
# output(scoreboard): (out_neg decimal_m), (out_neg decimal_e)

#Infinity -> -Infinity
execute if score in_neg decimal_e = int32_max decimal_const if score in_neg decimal_m = int32_max decimal_const run scoreboard players operation out_neg decimal_m = int32_min decimal_const
execute if score in_neg decimal_e = int32_max decimal_const if score in_neg decimal_m = int32_max decimal_const run scoreboard players operation out_neg decimal_e = int32_max decimal_const
execute if score in_neg decimal_e = int32_max decimal_const if score in_neg decimal_m = int32_max decimal_const run return 0
#-Infinity -> Infinity
execute if score in_neg decimal_e = int32_max decimal_const if score in_neg decimal_m = int32_min decimal_const run scoreboard players operation out_neg decimal_m = int32_max decimal_const
execute if score in_neg decimal_e = int32_max decimal_const if score in_neg decimal_m = int32_min decimal_const run scoreboard players operation out_neg decimal_e = int32_max decimal_const
execute if score in_neg decimal_e = int32_max decimal_const if score in_neg decimal_m = int32_min decimal_const run return 0

#NaN -> NaN
scoreboard players operation in_is_nan decimal_m = in_neg decimal_m
scoreboard players operation in_is_nan decimal_e = in_neg decimal_e
execute store result score is_nan decimal_tmp run function decimal:s/is_nan
execute if score is_nan decimal_tmp matches 1 run scoreboard players operation out_neg decimal_m = 1e9 decimal_const
execute if score is_nan decimal_tmp matches 1 run scoreboard players operation out_neg decimal_e = int32_max decimal_const
execute if score is_nan decimal_tmp matches 1 run return 0

scoreboard players set out_neg decimal_m 0
scoreboard players operation out_neg decimal_m -= in_neg decimal_m
scoreboard players operation out_neg decimal_e = in_neg decimal_e
return 0