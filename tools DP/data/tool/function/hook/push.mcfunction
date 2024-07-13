attribute @s minecraft:generic.gravity base set 0
$execute as @s at @s if entity @e[tag=hook_$(id), distance=2..] facing entity @e[tag=hook_$(id)] eyes positioned ^ ^ ^1 run tp @s ~ ~ ~
$execute as @s at @s if entity @e[tag=hook_$(id), distance=1..] facing entity @e[tag=hook_$(id)] eyes positioned ^ ^ ^0.1 run tp @s ~ ~ ~