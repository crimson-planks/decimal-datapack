#args(template): $(m), $(e)

$scoreboard players set in_normalize decimal_m $(m)
$scoreboard players set in_normalize decimal_e $(e)
function decimal:s/normalize
scoreboard players operation in_to_exponential decimal_m = out_normalize decimal_m
scoreboard players operation in_to_exponential decimal_e = out_normalize decimal_e
function decimal:s/to_exponential
tellraw @a [{text:"out to_exponential: "},{storage:"decimal:out",nbt:"to_exponential"}]