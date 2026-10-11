# arguments (scoreboard): floorlog10abs decimal_in
# output (return value)
execute if score floorlog10abs decimal_in matches 0 run return 0
execute if score floorlog10abs decimal_in = int32_min decimal_const run return 9
execute if score floorlog10abs decimal_in matches 0.. run scoreboard players operation floorlog10abs decimal_tmp = floorlog10abs decimal_in
execute if score floorlog10abs decimal_in matches ..-1 run scoreboard players set floorlog10abs decimal_tmp 0
execute if score floorlog10abs decimal_in matches ..-1 run scoreboard players operation floorlog10abs decimal_tmp -= floorlog10abs decimal_in
execute if score floorlog10abs decimal_tmp matches ..9 run return 0
execute if score floorlog10abs decimal_tmp matches ..99 run return 1
execute if score floorlog10abs decimal_tmp matches ..999 run return 2
execute if score floorlog10abs decimal_tmp matches ..9999 run return 3
execute if score floorlog10abs decimal_tmp matches ..99999 run return 4
execute if score floorlog10abs decimal_tmp matches ..999999 run return 5
execute if score floorlog10abs decimal_tmp matches ..9999999 run return 6
execute if score floorlog10abs decimal_tmp matches ..99999999 run return 7
execute if score floorlog10abs decimal_tmp matches ..999999999 run return 8
return 9