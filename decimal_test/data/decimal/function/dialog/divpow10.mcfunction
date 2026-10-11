#args(template): $(n), $(divval)

$scoreboard players set divpow10_n decimal_in $(n)
$scoreboard players set divpow10_divval decimal_in $(divval)
function decimal:divpow10
title @a title [{text: "n: "},{score:{name:"divpow10_n",objective:"decimal_out"}}]