# 총괄
scoreboard objectives add click minecraft.used:minecraft.carrot_on_a_stick
scoreboard players reset @a click

scoreboard objectives add id dummy
scoreboard players add max id 0

# 입체 기동 장치
kill @e[tag=hook_everyone]

# 끝
tellraw @a "[TOOL reloaded]"