

$scoreboard players set in_normalize decimal_m $(m1)
$scoreboard players set in_normalize decimal_e $(e1)
function decimal:s/normalize
scoreboard players operation in_mul_1 decimal_m = out_normalize decimal_m
scoreboard players operation in_mul_1 decimal_e = out_normalize decimal_e
$scoreboard players set in_normalize decimal_m $(m2)
$scoreboard players set in_normalize decimal_e $(e2)
function decimal:s/normalize
scoreboard players operation in_mul_2 decimal_m = out_normalize decimal_m
scoreboard players operation in_mul_2 decimal_e = out_normalize decimal_e
function decimal:s/mul
scoreboard players operation in_to_exponential decimal_m = out_mul decimal_m
scoreboard players operation in_to_exponential decimal_e = out_mul decimal_e
function decimal:s/to_exponential
tellraw @a [{text:"out_mul: "},{storage:"decimal:out",nbt:"to_exponential"}]