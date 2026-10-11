#

$scoreboard players set in_normalize decimal_m $(m1)
$scoreboard players set in_normalize decimal_e $(e1)
function decimal:s/normalize
scoreboard players operation in_add_1 decimal_m = out_normalize decimal_m
scoreboard players operation in_add_1 decimal_e = out_normalize decimal_e
$scoreboard players set in_normalize decimal_m $(m2)
$scoreboard players set in_normalize decimal_e $(e2)
function decimal:s/normalize
scoreboard players operation in_add_2 decimal_m = out_normalize decimal_m
scoreboard players operation in_add_2 decimal_e = out_normalize decimal_e
function decimal:s/add
#tellraw @a [{text:"in_add_1 m: ",},{score:{name:"in_add_1",objective:"decimal_m"}},{text:", in_add_1 e: "},{score:{name:"in_add_1",objective:"decimal_e"}}]
#tellraw @a [{text:"in_add_2 m: ",},{score:{name:"in_add_2",objective:"decimal_m"}},{text:", in_add_2 e: "},{score:{name:"in_add_2",objective:"decimal_e"}}]
#tellraw @a [{text:"out_add m: ",},{score:{name:"out_add",objective:"decimal_m"}},{text:", out_add e: "},{score:{name:"out_add",objective:"decimal_e"}}]
scoreboard players operation in_to_exponential decimal_m = out_add decimal_m
scoreboard players operation in_to_exponential decimal_e = out_add decimal_e
function decimal:s/to_exponential
tellraw @a [{text:"out_add: "},{storage:"decimal:out",nbt:"to_exponential"}]