scoreboard players reset @s click

particle minecraft:cloud
$execute if block ~ ~ ~ air positioned ^ ^ ^0.1 run return run function tool:hook/click with storage tool:player_$(id)

$kill @e[tag=hook_$(id)]
$summon marker ~ ~ ~ {Tags:[hook_$(id), hook_everyone]}
$data modify entity @e[tag=hook_$(id), limit=1] leash.UUID set from entity @s UUID