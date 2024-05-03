#총괄
$execute unless data storage tools:player_$(id) id run data modify storage tools:player_$(id) id set value $(id)

# 딱총 나무 지팡이
$execute unless data storage tools:player_$(id) mode run data modify storage tools:player_$(id) mode set value "pos"
$execute unless data storage tools:player_$(id) block run data modify storage tools:player_$(id) block set value "minecraft:stone"

$execute unless data storage tools:player_$(id) 2ndX run data modify storage tools:player_$(id) 2ndX set value 0
$execute unless data storage tools:player_$(id) 2ndY run data modify storage tools:player_$(id) 2ndY set value 0
$execute unless data storage tools:player_$(id) 2ndZ run data modify storage tools:player_$(id) 2ndZ set value 0

$execute unless data storage tools:player_$(id) 1stX run data modify storage tools:player_$(id) 1stX set value 0
$execute unless data storage tools:player_$(id) 1stY run data modify storage tools:player_$(id) 1stY set value 0
$execute unless data storage tools:player_$(id) 1stZ run data modify storage tools:player_$(id) 1stZ set value 0