# arguments(scoreboard): (in_to_exponential decimal_m), (in_to_exponential decimal_e)
# output (storage): decimal:out to_exponential
scoreboard players operation in_is_nan decimal_m = in_to_exponential decimal_m
scoreboard players operation in_is_nan decimal_e = in_to_exponential decimal_e
function decimal:s/is_nan
execute if score is_nan decimal_out matches 1 run data modify storage decimal:out to_exponential set value "NaN"
execute if score is_nan decimal_out matches 1 run return 0

execute if score in_to_exponential decimal_e = int32_max decimal_const if score in_to_exponential decimal_m = int32_max decimal_const run return run data modify storage decimal:out to_exponential set value "Infinity"
execute if score in_to_exponential decimal_e = int32_max decimal_const if score in_to_exponential decimal_m = int32_min decimal_const run return run data modify storage decimal:out to_exponential set value "-Infinity"

scoreboard players operation mFirstDigit decimal_tmp = in_to_exponential decimal_m
scoreboard players operation mFirstDigit decimal_tmp /= 1e8 decimal_const
scoreboard players operation mRDigits decimal_tmp = in_to_exponential decimal_m
scoreboard players operation mRDigits decimal_tmp %= 1e8 decimal_const
scoreboard players set fixMod decimal_tmp 0
execute if score mFirstDigit decimal_tmp matches ..-1 if score mRDigits decimal_tmp matches 1.. run scoreboard players set fixMod decimal_tmp 1
execute if score fixMod decimal_tmp matches 1 run scoreboard players operation mRDigitsOld decimal_tmp = mRDigits decimal_tmp
execute if score fixMod decimal_tmp matches 1 run scoreboard players operation mRDigits decimal_tmp = 1e8 decimal_const
execute if score fixMod decimal_tmp matches 1 run scoreboard players operation mRDigits decimal_tmp -= mRDigitsOld decimal_tmp
execute if score fixMod decimal_tmp matches 1 run scoreboard players add mFirstDigit decimal_tmp 1

scoreboard players operation floorlog10abs decimal_in = mRDigits decimal_tmp
execute store result score mRDigitsLength decimal_tmp run function decimal:floorlog10abs
scoreboard players set mRZeroPadRightLength decimal_tmp 7
scoreboard players operation mRZeroPadRightLength decimal_tmp -= mRDigitsLength decimal_tmp




data modify storage decimal:tmp to_exponential.macro set value {mFirstDigit:0,mRPadLeft:"0000000",mRDigits:0,mRPadRight:"",e:0}
execute store result storage decimal:tmp to_exponential.macro.mFirstDigit int 1 run scoreboard players get mFirstDigit decimal_tmp
execute store result storage decimal:tmp to_exponential.macro.mRDigits int 1 run scoreboard players get mRDigits decimal_tmp
execute store result storage decimal:tmp to_exponential.macro.e int 1 run scoreboard players get in_to_exponential decimal_e

execute store result storage decimal:tmp to_exponential.slice_mrpadleft.macro.length int 1 run scoreboard players get mRZeroPadRightLength decimal_tmp
function decimal:s/to_exponential/slice_mrpadleft with storage decimal:tmp to_exponential.slice_mrpadleft.macro


function decimal:s/to_exponential/core with storage decimal:tmp to_exponential.macro
tellraw @a [{text:"mRZeroPadRightLength: "},{score:{name:"mRZeroPadRightLength",objective:"decimal_tmp"}}]
tellraw @a [{text:"mFirstDigit: "},{score:{name:"mFirstDigit",objective:"decimal_tmp"}},{text:", mRDigits: "},{score:{name:"mRDigits",objective:"decimal_tmp"}},{text: ", e: "},{score:{name:"in_to_exponential",objective:"decimal_e"}}]
tellraw @a [{text:"to_exponential result: "},{storage:"decimal:out",nbt:"to_exponential"}]