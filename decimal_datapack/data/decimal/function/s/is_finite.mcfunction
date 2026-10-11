# arguments(scoreboard): (in_is_finite decimal_m), (in_is_finite decimal_e)
# output (return): 0 or 1
execute unless score in_is_finite decimal_e = int32_max decimal_const run return 1
execute if score in_is_finite decimal_m matches -999999999..999999999 run return 1
return 0