data merge storage decimal:out {normalize: {},to_string: {}}
data merge storage decimal:tmp {}
scoreboard objectives add decimal_in dummy
scoreboard objectives add decimal_out dummy
scoreboard objectives add decimal_m dummy
scoreboard objectives add decimal_e dummy
scoreboard objectives add decimal_tmp dummy
scoreboard objectives add decimal_const dummy
scoreboard players set 10 decimal_const 10
scoreboard players set -1 decimal_const -1
scoreboard players set 2 decimal_const 2
scoreboard players set 1e1 decimal_const 10
scoreboard players set 1e2 decimal_const 100
scoreboard players set 1e3 decimal_const 1000
scoreboard players set 1e4 decimal_const 10000
scoreboard players set 1e5 decimal_const 100000
scoreboard players set 1e6 decimal_const 1000000
scoreboard players set 1e7 decimal_const 10000000
scoreboard players set 1e8 decimal_const 100000000
scoreboard players set 1e9 decimal_const 1000000000
scoreboard players set int32_max decimal_const 2147483647
scoreboard players set int32_min decimal_const -2147483648

# maybe add a custom dimension?
execute in minecraft:overworld run forceload add 0 0
execute in minecraft:overworld unless entity @n[x=0.0,y=0.0,z=0.0,type=text_display,tag=decimal_text_resolver] run summon text_display 0.0 0.0 0.0 {Tags:["decimal_text_resolver"]}

tellraw @a {"text": "decimal loaded!","color": "green"}