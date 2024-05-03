scoreboard players reset @s click

$execute if block ~ ~ ~ air positioned ^ ^ ^0.1 run return run function tools:edit/click with storage tools:player_$(id)

# POS
$execute if data storage tools:player_$(id) {mode:"pos"} align xyz run summon minecraft:marker ~ ~ ~ {Tags:["edit$(id)"]}

$execute if data storage tools:player_$(id) {mode:"pos"} run data modify storage tools:player_$(id) 1stX set from storage tools:player_$(id) 2ndX
$execute if data storage tools:player_$(id) {mode:"pos"} run data modify storage tools:player_$(id) 1stY set from storage tools:player_$(id) 2ndY
$execute if data storage tools:player_$(id) {mode:"pos"} run data modify storage tools:player_$(id) 1stZ set from storage tools:player_$(id) 2ndZ

$execute if data storage tools:player_$(id) {mode:"pos"} run data modify storage tools:player_$(id) 2ndX set from entity @e[tag=edit$(id), limit=1] Pos[0]
$execute if data storage tools:player_$(id) {mode:"pos"} run data modify storage tools:player_$(id) 2ndY set from entity @e[tag=edit$(id), limit=1] Pos[1]
$execute if data storage tools:player_$(id) {mode:"pos"} run data modify storage tools:player_$(id) 2ndZ set from entity @e[tag=edit$(id), limit=1] Pos[2]

$execute if data storage tools:player_$(id) {mode:"pos"} run kill @e[tag=edit$(id)]
$execute if data storage tools:player_$(id) {mode:"pos"} run function tools:edit/pos with storage tools:player_$(id)

# SET
$execute if data storage tools:player_$(id) {mode:"set"} run function tools:edit/set with storage tools:player_$(id)

# CUT
$execute if data storage tools:player_$(id) {mode:"cut"} run function tools:edit/cut with storage tools:player_$(id)