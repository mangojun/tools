# 기존 1st 데이터를 2nd 데이터에 옮김
$data modify storage tool:player_$(id) 1stX set from storage tool:player_$(id) 2ndX
$data modify storage tool:player_$(id) 1stY set from storage tool:player_$(id) 2ndY
$data modify storage tool:player_$(id) 1stZ set from storage tool:player_$(id) 2ndZ
$data modify storage tool:player_$(id) 1stB set from storage tool:player_$(id) 2ndB

# 새롭게 1st 데이터 생성
$execute align xyz run summon minecraft:marker ~ ~ ~ {Tags:["edit_$(id)"]}
$data modify storage tool:player_$(id) 2ndX set from entity @e[tag=edit_$(id), limit=1] Pos[0]
$data modify storage tool:player_$(id) 2ndY set from entity @e[tag=edit_$(id), limit=1] Pos[1]
$data modify storage tool:player_$(id) 2ndZ set from entity @e[tag=edit_$(id), limit=1] Pos[2]
$kill @e[tag=edit_$(id)]

loot spawn ~ ~ ~ mine ~ ~ ~ minecraft:stick[minecraft:enchantments={levels:{"minecraft:silk_touch":1}}]
$data modify storage tool:player_$(id) 2ndB set from entity @e[type=item, limit=1, sort=nearest] Item.id
kill @e[type=item, limit=1, sort=nearest]

$execute if block ~ ~ ~ minecraft:water run data modify storage tool:player_$(id) 2ndB set value "minecraft:water"
$execute if block ~ ~ ~ minecraft:lava run data modify storage tool:player_$(id) 2ndB set value "minecraft:lava"
$execute if block ~ ~ ~ minecraft:bedrock run data modify storage tool:player_$(id) 2ndB set value "minecraft:bedrock"

# 출력
$title @s actionbar ["", {"text":"[EDIT $(id)] ", "bold":true}, {"text":"$(2ndX) ", "color":"red"}, {"text":"$(2ndY) ", "color":"green"}, {"text":"$(2ndZ)", "color":"blue"}, "부터 ", {"storage":"tool:player_$(id)", "nbt":"2ndX", "color":"red"}, " ", {"storage":"tool:player_$(id)", "nbt":"2ndY", "color":"green"}, " ", {"storage":"tool:player_$(id)", "nbt":"2ndZ", "color":"blue"}, "까지의 영역을 선택했습니다"]