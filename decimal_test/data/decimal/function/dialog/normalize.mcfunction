#args(template): $(m), $(e)

$scoreboard players set in_normalize decimal_m $(m)
$scoreboard players set in_normalize decimal_e $(e)
function decimal:s/normalize
#title @a title [{text:"m: ",},{score:{name:"out_normalize",objective:"decimal_m"}},{text:", e: "},{score:{name:"out_normalize",objective:"decimal_e"}}]
scoreboard players operation in_to_exponential decimal_m = out_normalize decimal_m
scoreboard players operation in_to_exponential decimal_e = out_normalize decimal_e
function decimal:s/to_exponential
tellraw @a [{text:"out_normalize: "},{storage:"decimal:out",nbt:"to_exponential"}]