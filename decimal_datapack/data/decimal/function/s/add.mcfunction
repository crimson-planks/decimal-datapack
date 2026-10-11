# arguments(scoreboard): (in_add_1 decimal_m), (in_add_2 decimal_m), (in_add_1 decimal_e),(in_add_2 decimal_e)
# output(scoreboard): (out_add decimal_m), (out_add decimal_e)

execute if score in_add_1 decimal_m matches 0 run scoreboard players operation out_add decimal_m = in_add_2 decimal_m
execute if score in_add_1 decimal_m matches 0 run scoreboard players operation out_add decimal_e = in_add_2 decimal_e
execute if score in_add_1 decimal_m matches 0 run return 0
execute if score in_add_2 decimal_m matches 0 run scoreboard players operation out_add decimal_m = in_add_1 decimal_m
execute if score in_add_2 decimal_m matches 0 run scoreboard players operation out_add decimal_e = in_add_1 decimal_e
execute if score in_add_2 decimal_m matches 0 run return 0

#NaN check
scoreboard players set isnan decimal_tmp 0
scoreboard players operation in_is_nan decimal_m = in_add_1 decimal_m
scoreboard players operation in_is_nan decimal_e = in_add_1 decimal_e
execute if function decimal:s/is_nan run scoreboard players set isnan decimal_tmp 1
scoreboard players operation in_is_nan decimal_m = in_add_2 decimal_m
scoreboard players operation in_is_nan decimal_e = in_add_2 decimal_e
execute if function decimal:s/is_nan run scoreboard players set isnan decimal_tmp 1
execute if score isnan decimal_tmp matches 1 run scoreboard players operation out_add decimal_m = 1e9 decimal_const
execute if score isnan decimal_tmp matches 1 run scoreboard players operation out_add decimal_e = int32_max decimal_const
execute if score isnan decimal_tmp matches 1 run return 0

scoreboard players operation big_m decimal_tmp = in_add_1 decimal_m
scoreboard players operation big_e decimal_tmp = in_add_1 decimal_e
scoreboard players operation small_m decimal_tmp = in_add_2 decimal_m
scoreboard players operation small_e decimal_tmp = in_add_2 decimal_e
execute if score big_e decimal_tmp < small_e decimal_tmp run scoreboard players operation big_m decimal_tmp >< small_m decimal_tmp
execute if score big_e decimal_tmp < small_e decimal_tmp run scoreboard players operation big_e decimal_tmp >< small_e decimal_tmp

#Infinity and -Infinity check
scoreboard players set isinf decimal_tmp 0
execute if score big_e decimal_tmp = int32_max decimal_const if score big_m decimal_tmp = int32_max decimal_const run scoreboard players set isinf decimal_tmp 1
scoreboard players set isneginf decimal_tmp 0
execute if score small_e decimal_tmp = int32_max decimal_const if score small_e decimal_tmp = int32_min decimal_const run scoreboard players set isneginf decimal_tmp 1
execute if score isinf decimal_tmp matches 1 if score isneginf decimal_tmp matches 1 run scoreboard players operation out_add decimal_m = 1e9 decimal_const
execute if score isinf decimal_tmp matches 1 if score isneginf decimal_tmp matches 1 run scoreboard players operation out_add decimal_e = int32_max decimal_const
execute if score isinf decimal_tmp matches 1 if score isneginf decimal_tmp matches 1 run return 0
execute if score isinf decimal_tmp matches 1 run scoreboard players operation out_add decimal_m = int32_max decimal_const
execute if score isinf decimal_tmp matches 1 run scoreboard players operation out_add decimal_e = int32_max decimal_const
execute if score isinf decimal_tmp matches 1 run return 0
execute if score isneginf decimal_tmp matches 1 run scoreboard players operation out_add decimal_m = int32_min decimal_const
execute if score isneginf decimal_tmp matches 1 run scoreboard players operation out_add decimal_e = int32_max decimal_const
execute if score isneginf decimal_tmp matches 1 run return 0

tellraw @a [{text:"big_m: "},{score:{name:"big_m",objective:"decimal_tmp"}},{text:"big_e: "},{score:{name:"big_e",objective:"decimal_tmp"}}]

scoreboard players operation eDiff decimal_tmp = big_e decimal_tmp
scoreboard players operation eDiff decimal_tmp -= small_e decimal_tmp
execute if score eDiff decimal_tmp matches 9.. run scoreboard players operation out_add decimal_m = big_m decimal_tmp
execute if score eDiff decimal_tmp matches 9.. run scoreboard players operation out_add decimal_e = big_e decimal_tmp
execute if score eDiff decimal_tmp matches 9 if score small_m decimal_tmp matches 500000000.. run scoreboard players add out_add decimal_m 1
execute if score eDiff decimal_tmp matches 9 if score small_m decimal_tmp matches ..-500000000 run scoreboard players remove out_add decimal_m 1
execute if score eDiff decimal_tmp matches 9.. run return 0

# 0<=eDiff<=8
# small_m_divd = divide small_m by 10^eDiff, m=big_m+small_m_divd, normalize then return

scoreboard players operation intpow10 decimal_in = eDiff decimal_tmp
execute store result score divpow10_divval decimal_in run function decimal:intpow10
scoreboard players operation divpow10_n decimal_in = small_m decimal_tmp
execute store result score small_m_divd decimal_tmp run function decimal:divpow10
scoreboard players operation out_add decimal_m = big_m decimal_tmp
scoreboard players operation out_add decimal_m += small_m_divd decimal_tmp
scoreboard players operation out_add decimal_e = big_e decimal_tmp
execute if score out_add decimal_e = int32_max decimal_const if score out_add decimal_m <= 1e9 decimal_const run scoreboard players operation out_add decimal_m = int32_max decimal_const
scoreboard players operation in_normalize decimal_m = out_add decimal_m
scoreboard players operation in_normalize decimal_e = out_add decimal_e
function decimal:s/normalize
scoreboard players operation out_add decimal_m = out_normalize decimal_m
scoreboard players operation out_add decimal_e = out_normalize decimal_e
return 0