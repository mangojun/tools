scoreboard players reset @s click

$execute if block ~ ~ ~ air positioned ^ ^ ^0.1 run return run function tool:edit/click with storage tool:player_$(id)

$execute if data storage tool:player_$(id) {mode:"pos"} run function tool:edit/func/pos with storage tool:player_$(id)
$execute if data storage tool:player_$(id) {mode:"set"} run function tool:edit/func/set with storage tool:player_$(id)
$execute if data storage tool:player_$(id) {mode:"cut"} run function tool:edit/func/cut with storage tool:player_$(id)
$execute if data storage tool:player_$(id) {mode:"rpl"} run function tool:edit/func/rpl with storage tool:player_$(id)