# arguments(scoreboard): (in_mul_1 decimal_m), (in_mul_2 decimal_m), (in_mul_1 decimal_e),(in_mul_2 decimal_e)
# output(scoreboard): (out_mul decimal_m), (out_mul decimal_e)


# m stands for myriad(10000)
execute store result score a_isneg decimal_tmp if score in_mul_1 decimal_m matches ..-1
execute store result score b_isneg decimal_tmp if score in_mul_2 decimal_m matches ..-1

scoreboard players operation in_is_nan decimal_m = in_mul_1 decimal_m
scoreboard players operation in_is_nan decimal_e = in_mul_1 decimal_e
execute store result score is_nan decimal_tmp run function decimal:s/is_nan
execute if score is_nan decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m = 1e9 decimal_const
execute if score is_nan decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m = int32_max decimal_const
execute if score is_nan decimal_tmp matches 1 run return 0

scoreboard players operation in_is_nan decimal_m = in_mul_2 decimal_m
scoreboard players operation in_is_nan decimal_e = in_mul_2 decimal_e
execute store result score is_nan decimal_tmp run function decimal:s/is_nan
execute if score is_nan decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m = 1e9 decimal_const
execute if score is_nan decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m = int32_max decimal_const
execute if score is_nan decimal_tmp matches 1 run return 0

scoreboard players operation in_is_finite decimal_m = in_mul_1 decimal_m
scoreboard players operation in_is_finite decimal_e = in_mul_1 decimal_e
execute store result score is_finite decimal_tmp run function decimal:s/is_finite
# I * 0 = N
execute if score is_finite decimal_tmp matches 0 if score in_mul_2 decimal_m matches 0 run scoreboard players operation out_mul decimal_m = 1e9 decimal_const
execute if score is_finite decimal_tmp matches 0 if score in_mul_2 decimal_m matches 0 run scoreboard players operation out_mul decimal_m = int32_max decimal_const
execute if score is_finite decimal_tmp matches 0 if score in_mul_2 decimal_m matches 0 run return 0
# I * finite
execute if score is_finite decimal_tmp matches 0 if score pd_isneg decimal_tmp matches 0 run scoreboard players operation out_mul decimal_m = int32_max decimal_const
execute if score is_finite decimal_tmp matches 0 if score pd_isneg decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m = int32_min decimal_const
execute if score is_finite decimal_tmp matches 0 run scoreboard players operation out_mul decimal_e = int32_max decimal_const
execute if score is_finite decimal_tmp matches 0 run return 0

scoreboard players operation in_is_finite decimal_m = in_mul_2 decimal_m
scoreboard players operation in_is_finite decimal_e = in_mul_2 decimal_e
execute store result score is_finite decimal_tmp run function decimal:s/is_finite
execute if score is_finite decimal_tmp matches 0 if score in_mul_1 decimal_m matches 0 run scoreboard players operation out_mul decimal_m = 1e9 decimal_const
execute if score is_finite decimal_tmp matches 0 if score in_mul_1 decimal_m matches 0 run scoreboard players operation out_mul decimal_m = int32_max decimal_const
execute if score is_finite decimal_tmp matches 0 if score in_mul_1 decimal_m matches 0 run return 0
execute if score is_finite decimal_tmp matches 0 if score pd_isneg decimal_tmp matches 0 run scoreboard players operation out_mul decimal_m = int32_max decimal_const
execute if score is_finite decimal_tmp matches 0 if score pd_isneg decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m = int32_min decimal_const
execute if score is_finite decimal_tmp matches 0 run scoreboard players operation out_mul decimal_e = int32_max decimal_const
execute if score is_finite decimal_tmp matches 0 run return 0


execute if score in_mul_1 decimal_m matches 0 run scoreboard players set out_mul decimal_m 0
execute if score in_mul_1 decimal_m matches 0 run scoreboard players set out_mul decimal_e 0
execute if score in_mul_1 decimal_m matches 0 run return 0
execute if score in_mul_2 decimal_m matches 0 run scoreboard players set out_mul decimal_m 0
execute if score in_mul_2 decimal_m matches 0 run scoreboard players set out_mul decimal_e 0
execute if score in_mul_2 decimal_m matches 0 run return 0

scoreboard players operation in_normalize decimal_m = in_mul_1 decimal_m
scoreboard players operation in_normalize decimal_e = in_mul_1 decimal_e
function decimal:s/normalize
scoreboard players operation in_mul_1 decimal_m = out_normalize decimal_m
scoreboard players operation in_mul_1 decimal_e = out_normalize decimal_e
scoreboard players operation in_normalize decimal_m = in_mul_2 decimal_m
scoreboard players operation in_normalize decimal_e = in_mul_2 decimal_e
function decimal:s/normalize
scoreboard players operation in_mul_2 decimal_m = out_normalize decimal_m
scoreboard players operation in_mul_2 decimal_e = out_normalize decimal_e

scoreboard players operation pd_isneg decimal_tmp = a_isneg decimal_tmp
scoreboard players operation pd_isneg decimal_tmp += b_isneg decimal_tmp
execute if score pd_isneg decimal_tmp matches 2 run scoreboard players set pd_isneg decimal_tmp 0



scoreboard players operation a_m0 decimal_tmp = in_mul_1 decimal_m
scoreboard players operation a_m0 decimal_tmp %= 1e4 decimal_const
scoreboard players operation a_m1 decimal_tmp = in_mul_1 decimal_m
scoreboard players operation a_m1 decimal_tmp /= 1e4 decimal_const
scoreboard players operation a_m2 decimal_tmp = a_m1 decimal_tmp
scoreboard players operation a_m2 decimal_tmp /= 1e4 decimal_const
scoreboard players operation a_m1 decimal_tmp %= 1e4 decimal_const
execute if score a_isneg decimal_tmp matches 1 if score a_m0 decimal_tmp matches 1.. run scoreboard players add a_m1 decimal_tmp 1
execute if score a_isneg decimal_tmp matches 1 if score a_m0 decimal_tmp matches 1.. run scoreboard players operation a_m0 decimal_tmp -= 1e4 decimal_const
execute if score a_isneg decimal_tmp matches 1 if score a_m1 decimal_tmp matches 1.. run scoreboard players add a_m2 decimal_tmp 1
execute if score a_isneg decimal_tmp matches 1 if score a_m1 decimal_tmp matches 1.. run scoreboard players operation a_m1 decimal_tmp -= 1e4 decimal_const


scoreboard players operation b_m0 decimal_tmp = in_mul_2 decimal_m
scoreboard players operation b_m0 decimal_tmp %= 1e4 decimal_const
scoreboard players operation b_m1 decimal_tmp = in_mul_2 decimal_m
scoreboard players operation b_m1 decimal_tmp /= 1e4 decimal_const
scoreboard players operation b_m2 decimal_tmp = b_m1 decimal_tmp
scoreboard players operation b_m2 decimal_tmp /= 1e4 decimal_const
scoreboard players operation b_m1 decimal_tmp %= 1e4 decimal_const
execute if score b_isneg decimal_tmp matches 1 if score b_m0 decimal_tmp matches 1.. run scoreboard players add b_m1 decimal_tmp 1
execute if score b_isneg decimal_tmp matches 1 if score b_m0 decimal_tmp matches 1.. run scoreboard players operation b_m0 decimal_tmp -= 1e4 decimal_const
execute if score b_isneg decimal_tmp matches 1 if score b_m1 decimal_tmp matches 1.. run scoreboard players add b_m2 decimal_tmp 1
execute if score b_isneg decimal_tmp matches 1 if score b_m1 decimal_tmp matches 1.. run scoreboard players operation b_m1 decimal_tmp -= 1e4 decimal_const

tellraw @a [{score:{name:"a_m2",objective:"decimal_tmp"}},{text:" "},{score:{name:"a_m1",objective:"decimal_tmp"}},{text:" "},{score:{name:"a_m0",objective:"decimal_tmp"}},{text:" "},{score:{name:"b_m2",objective:"decimal_tmp"}},{text:" "},{score:{name:"b_m1",objective:"decimal_tmp"}},{text:" "},{score:{name:"b_m0",objective:"decimal_tmp"}}]

scoreboard players operation pd_m0 decimal_tmp = a_m0 decimal_tmp
scoreboard players operation pd_m0 decimal_tmp *= b_m0 decimal_tmp

scoreboard players operation pd_m1 decimal_tmp = a_m1 decimal_tmp
scoreboard players operation pd_m1 decimal_tmp *= b_m0 decimal_tmp
scoreboard players operation tmpmul decimal_tmp = a_m0 decimal_tmp
scoreboard players operation tmpmul decimal_tmp *= b_m1 decimal_tmp
scoreboard players operation pd_m1 decimal_tmp += tmpmul decimal_tmp

scoreboard players operation pd_m2 decimal_tmp = a_m2 decimal_tmp
scoreboard players operation pd_m2 decimal_tmp *= b_m0 decimal_tmp
scoreboard players operation tmpmul decimal_tmp = a_m1 decimal_tmp
scoreboard players operation tmpmul decimal_tmp *= b_m1 decimal_tmp
scoreboard players operation pd_m2 decimal_tmp += tmpmul decimal_tmp
scoreboard players operation tmpmul decimal_tmp = a_m0 decimal_tmp
scoreboard players operation tmpmul decimal_tmp *= b_m2 decimal_tmp
scoreboard players operation pd_m2 decimal_tmp += tmpmul decimal_tmp

scoreboard players operation pd_m3 decimal_tmp = a_m2 decimal_tmp
scoreboard players operation pd_m3 decimal_tmp *= b_m1 decimal_tmp
scoreboard players operation tmpmul decimal_tmp = a_m1 decimal_tmp
scoreboard players operation tmpmul decimal_tmp *= b_m2 decimal_tmp
scoreboard players operation pd_m3 decimal_tmp += tmpmul decimal_tmp

scoreboard players operation pd_m4 decimal_tmp = a_m2 decimal_tmp
scoreboard players operation pd_m4 decimal_tmp *= b_m2 decimal_tmp
tellraw @a [{score:{name:"pd_m4",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m3",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m2",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m1",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m0",objective:"decimal_tmp"}},{text:" "},]

scoreboard players operation divd decimal_tmp = pd_m0 decimal_tmp
scoreboard players operation divd decimal_tmp /= 1e4 decimal_const
scoreboard players operation pd_m1 decimal_tmp += divd decimal_tmp
scoreboard players operation pd_m0 decimal_tmp %= 1e4 decimal_const
tellraw @a [{score:{name:"pd_m4",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m3",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m2",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m1",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m0",objective:"decimal_tmp"}},{text:" "},]
scoreboard players operation divd decimal_tmp = pd_m1 decimal_tmp
scoreboard players operation divd decimal_tmp /= 1e4 decimal_const
scoreboard players operation pd_m2 decimal_tmp += divd decimal_tmp
scoreboard players operation pd_m1 decimal_tmp %= 1e4 decimal_const
tellraw @a [{score:{name:"pd_m4",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m3",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m2",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m1",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m0",objective:"decimal_tmp"}},{text:" "},]
scoreboard players operation divd decimal_tmp = pd_m2 decimal_tmp
scoreboard players operation divd decimal_tmp /= 1e4 decimal_const
scoreboard players operation pd_m3 decimal_tmp += divd decimal_tmp
scoreboard players operation pd_m2 decimal_tmp %= 1e4 decimal_const
tellraw @a [{score:{name:"pd_m4",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m3",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m2",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m1",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m0",objective:"decimal_tmp"}},{text:" "},]
scoreboard players operation divd decimal_tmp = pd_m3 decimal_tmp
scoreboard players operation divd decimal_tmp /= 1e4 decimal_const
scoreboard players operation pd_m4 decimal_tmp += divd decimal_tmp
scoreboard players operation pd_m3 decimal_tmp %= 1e4 decimal_const
tellraw @a [{score:{name:"pd_m4",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m3",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m2",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m1",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m0",objective:"decimal_tmp"}},{text:" "},]
execute if score pd_isneg decimal_tmp matches 1 if score pd_m0 decimal_tmp matches 1.. run scoreboard players add pd_m1 decimal_tmp 1
execute if score pd_isneg decimal_tmp matches 1 if score pd_m0 decimal_tmp matches 1.. run scoreboard players operation pd_m0 decimal_tmp -= 1e4 decimal_const
execute if score pd_isneg decimal_tmp matches 1 if score pd_m1 decimal_tmp matches 1.. run scoreboard players add pd_m2 decimal_tmp 1
execute if score pd_isneg decimal_tmp matches 1 if score pd_m1 decimal_tmp matches 1.. run scoreboard players operation pd_m1 decimal_tmp -= 1e4 decimal_const
execute if score pd_isneg decimal_tmp matches 1 if score pd_m2 decimal_tmp matches 1.. run scoreboard players add pd_m3 decimal_tmp 1
execute if score pd_isneg decimal_tmp matches 1 if score pd_m2 decimal_tmp matches 1.. run scoreboard players operation pd_m2 decimal_tmp -= 1e4 decimal_const
execute if score pd_isneg decimal_tmp matches 1 if score pd_m3 decimal_tmp matches 1.. run scoreboard players add pd_m4 decimal_tmp 1
execute if score pd_isneg decimal_tmp matches 1 if score pd_m3 decimal_tmp matches 1.. run scoreboard players operation pd_m3 decimal_tmp -= 1e4 decimal_const
tellraw @a [{score:{name:"pd_m4",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m3",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m2",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m1",objective:"decimal_tmp"}},{text:" "},{score:{name:"pd_m0",objective:"decimal_tmp"}},{text:" "},]

#TODO: overflow
scoreboard players operation out_mul decimal_e = in_mul_1 decimal_e
scoreboard players operation out_mul decimal_e += in_mul_2 decimal_e
scoreboard players set is_overflow decimal_tmp 0
execute if score in_mul_1 decimal_e matches 1.. if score in_mul_2 decimal_e matches 1.. if score out_mul decimal_e matches ..-1 run scoreboard players set is_overflow decimal_tmp 1
execute if score is_overflow decimal_tmp matches 1 if score pd_isneg decimal_tmp matches 0 run scoreboard players operation out_mul decimal_m = int32_max decimal_const
execute if score is_overflow decimal_tmp matches 1 if score pd_isneg decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m = int32_min decimal_const
execute if score is_overflow decimal_tmp matches 1 run scoreboard players operation out_mul decimal_e = int32_max decimal_const
execute if score is_overflow decimal_tmp matches 1 run return 0
scoreboard players set is_underflow decimal_tmp 0
execute if score in_mul_1 decimal_e matches ..-1 if score in_mul_2 decimal_e matches ..-1 if score out_mul decimal_e matches 1.. run scoreboard players set is_underflow decimal_tmp 1
execute if score is_underflow decimal_tmp matches 1 run scoreboard players set out_mul decimal_m 0
execute if score is_underflow decimal_tmp matches 1 run scoreboard players set out_mul decimal_e 0
execute if score is_underflow decimal_tmp matches 1 run return 0
scoreboard players set out_mul decimal_m 0

execute store success score e_notadd decimal_tmp if score pd_m4 decimal_tmp matches -9..9
execute if score e_notadd decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m += pd_m4 decimal_tmp
execute if score e_notadd decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m *= 1e4 decimal_const
execute if score e_notadd decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m += pd_m3 decimal_tmp
execute if score e_notadd decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m *= 1e4 decimal_const
execute if score e_notadd decimal_tmp matches 1 run scoreboard players operation out_mul decimal_m += pd_m2 decimal_tmp
scoreboard players set check_ifeven decimal_tmp 0
execute if score e_notadd decimal_tmp matches 1 if score pd_m1 decimal_tmp matches 5000 if score pd_m0 decimal_tmp matches 0 run scoreboard players set check_ifeven decimal_tmp 1
execute if score e_notadd decimal_tmp matches 1 if score pd_m1 decimal_tmp matches -5000 if score pd_m0 decimal_tmp matches 0 run scoreboard players set check_ifeven decimal_tmp 1
execute if score check_ifeven decimal_tmp matches 1 run scoreboard players operation pd_mod2 decimal_tmp = pd_m2 decimal_tmp
execute if score check_ifeven decimal_tmp matches 1 run scoreboard players operation pd_mod2 decimal_tmp %= 2 decimal_const
execute if score check_ifeven decimal_tmp matches 1 if score pd_mod2 decimal_tmp matches 1 if score pd_isneg decimal_tmp matches 0 run scoreboard players add out_mul decimal_m 1
execute if score check_ifeven decimal_tmp matches 1 if score pd_mod2 decimal_tmp matches 1 if score pd_isneg decimal_tmp matches 1 run scoreboard players remove out_mul decimal_m 1
execute if score e_notadd decimal_tmp matches 1 if score pd_m1 decimal_tmp matches 5000.. if score check_ifeven decimal_tmp matches 0 run scoreboard players add out_mul decimal_m 1
execute if score e_notadd decimal_tmp matches 1 if score pd_m1 decimal_tmp matches ..-5000 if score check_ifeven decimal_tmp matches 0 run scoreboard players remove out_mul decimal_m 1
scoreboard players set check_ifeven decimal_tmp 0
execute if score e_notadd decimal_tmp matches 0 run scoreboard players add out_mul decimal_e 1
execute if score e_notadd decimal_tmp matches 0 run scoreboard players operation out_mul decimal_m += pd_m4 decimal_tmp
execute if score e_notadd decimal_tmp matches 0 run scoreboard players operation out_mul decimal_m *= 1e4 decimal_const
execute if score e_notadd decimal_tmp matches 0 run scoreboard players operation out_mul decimal_m += pd_m3 decimal_tmp
execute if score e_notadd decimal_tmp matches 0 run scoreboard players operation out_mul decimal_m *= 1e3 decimal_const
execute if score e_notadd decimal_tmp matches 0 run scoreboard players operation pd_div decimal_tmp = pd_m2 decimal_tmp
execute if score e_notadd decimal_tmp matches 0 run scoreboard players operation pd_div decimal_tmp /= 10 decimal_const
execute if score e_notadd decimal_tmp matches 0 run scoreboard players operation pd_mod decimal_tmp = pd_m2 decimal_tmp
execute if score e_notadd decimal_tmp matches 0 run scoreboard players operation pd_mod decimal_tmp %= 10 decimal_const
execute if score e_notadd decimal_tmp matches 0 if score pd_isneg decimal_tmp matches 1 unless score pd_mod decimal_tmp matches 0 run scoreboard players add pd_div decimal_tmp 1
execute if score e_notadd decimal_tmp matches 0 if score pd_isneg decimal_tmp matches 1 unless score pd_mod decimal_tmp matches 0 run scoreboard players set pd_mod_tmp decimal_tmp -10
execute if score e_notadd decimal_tmp matches 0 if score pd_isneg decimal_tmp matches 1 unless score pd_mod decimal_tmp matches 0 run scoreboard players operation pd_mod_tmp decimal_tmp += pd_mod decimal_tmp
execute if score e_notadd decimal_tmp matches 0 if score pd_isneg decimal_tmp matches 1 unless score pd_mod decimal_tmp matches 0 run scoreboard players operation pd_mod decimal_tmp = pd_mod_tmp decimal_tmp
execute if score e_notadd decimal_tmp matches 0 if score pd_isneg decimal_tmp matches 1 unless score pd_mod decimal_tmp matches 0
execute if score e_notadd decimal_tmp matches 0 run scoreboard players operation out_mul decimal_m += pd_div decimal_tmp
execute if score e_notadd decimal_tmp matches 0 if score pd_mod decimal_tmp matches 5 if score pd_m1 decimal_tmp matches 0 if score pd_m0 decimal_tmp matches 0 run scoreboard players set check_ifeven decimal_tmp 1
execute if score e_notadd decimal_tmp matches 0 if score pd_mod decimal_tmp matches -5 if score pd_m1 decimal_tmp matches 0 if score pd_m0 decimal_tmp matches 0 run scoreboard players set check_ifeven decimal_tmp 1
execute if score check_ifeven decimal_tmp matches 1 run scoreboard players operation pd_div_mod2 decimal_tmp = pd_div decimal_tmp
execute if score check_ifeven decimal_tmp matches 1 run scoreboard players operation pd_div_mod2 decimal_tmp %= 2 decimal_const
execute if score check_ifeven decimal_tmp matches 1 if score pd_div_mod2 decimal_tmp matches 1 if score pd_isneg decimal_tmp matches 0 run scoreboard players add out_mul decimal_m 1
execute if score check_ifeven decimal_tmp matches 1 if score pd_div_mod2 decimal_tmp matches 1 if score pd_isneg decimal_tmp matches 1 run scoreboard players remove out_mul decimal_m 1