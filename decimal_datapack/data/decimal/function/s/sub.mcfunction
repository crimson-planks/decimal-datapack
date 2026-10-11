# arguments(scoreboard): (in_sub_1 decimal_m), (in_sub_2 decimal_m), (in_sub_1 decimal_e),(in_sub_2 decimal_e)
# output(scoreboard): (out_sub decimal_m), (out_sub decimal_e)

scoreboard players operation in_neg decimal_m = in_sub_2 decimal_m
scoreboard players operation in_neg decimal_e = in_sub_2 decimal_e
function decimal:s/neg
scoreboard players operation in_add_1 decimal_m = in_sub_1 decimal_m
scoreboard players operation in_add_1 decimal_e = in_sub_1 decimal_e
scoreboard players operation in_add_2 decimal_m = out_neg decimal_m
scoreboard players operation in_add_2 decimal_e = out_neg decimal_e
function decimal:s/add
scoreboard players operation out_sub decimal_m = out_add decimal_m
scoreboard players operation out_sub decimal_e = out_add decimal_e