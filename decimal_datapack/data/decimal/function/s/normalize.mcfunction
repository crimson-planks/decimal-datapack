# arguments(scoreboard): (in_normalize decimal_m), (in_normalize decimal_e)
# output(scoreboard): (out_normalize decimal_m), (out_normalize decimal_e)

scoreboard players operation out_normalize decimal_m = in_normalize decimal_m
scoreboard players operation out_normalize decimal_e = in_normalize decimal_e

# Normalize 0(0,any) to (0, 0) (return)
execute if score out_normalize decimal_m matches 0 run return run scoreboard players set out_normalize decimal_e 0

scoreboard players set normalize_bemax decimal_tmp 0
execute if score out_normalize decimal_e = int32_max decimal_const run scoreboard players set normalize_bemax decimal_tmp 1
# Infinity(int32_max,int32_max)
execute if score normalize_bemax decimal_tmp matches 1 if score out_normalize decimal_m = int32_max decimal_const run return 0
# -Infinity(int32_min,int32_max)
execute if score normalize_bemax decimal_tmp matches 1 if score out_normalize decimal_m = int32_min decimal_const run return 0
# Normalize NaN to (1e9,int32_max)
execute if score normalize_bemax decimal_tmp matches 1 if score out_normalize decimal_m matches -999999999..999999999 run scoreboard players set normalize_bemax decimal_tmp 0
execute if score normalize_bemax decimal_tmp matches 1 run scoreboard players set out_normalize decimal_m 1000000000
execute if score normalize_bemax decimal_tmp matches 1 run return 0

#if abs(m)>=1_000_000_000 (1e9): divide m by 10, and decide if m should +=1, abiding to ties to even rounding
scoreboard players set normalize_bdiv decimal_tmp 1
execute if score out_normalize decimal_m matches -999999999..999999999 run scoreboard players set normalize_bdiv decimal_tmp 0
execute if score normalize_bdiv decimal_tmp matches 1 run scoreboard players operation divpow10_n decimal_in = out_normalize decimal_m
execute if score normalize_bdiv decimal_tmp matches 1 run scoreboard players set divpow10_divval decimal_in 10
execute if score normalize_bdiv decimal_tmp matches 1 store result score out_normalize decimal_m run function decimal:divpow10
execute if score normalize_bdiv decimal_tmp matches 1 run scoreboard players add out_normalize decimal_e 1
execute if score normalize_bdiv decimal_tmp matches 1 run return 0

#if abs(m)<100_000_000 (1e8): multiply
scoreboard players operation floorlog10abs decimal_in = out_normalize decimal_m
execute store result score l decimal_tmp run function decimal:floorlog10abs
scoreboard players set 8-l decimal_tmp 8
scoreboard players operation 8-l decimal_tmp -= l decimal_tmp
execute if score 8-l decimal_tmp matches 1.. run scoreboard players operation intpow10 decimal_in = 8-l decimal_tmp
execute if score 8-l decimal_tmp matches 1.. store result score 10pow8-l decimal_tmp run function decimal:intpow10
execute if score 8-l decimal_tmp matches 1.. run scoreboard players operation out_normalize decimal_m *= 10pow8-l decimal_tmp
execute if score 8-l decimal_tmp matches 1.. run scoreboard players operation out_normalize decimal_e -= 8-l decimal_tmp
execute if score 8-l decimal_tmp matches 1.. run return 0

return 0