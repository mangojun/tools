item replace entity @s weapon.offhand from entity @s weapon.mainhand
item replace entity @s weapon.mainhand with minecraft:carrot_on_a_stick[minecraft:custom_name='{"text":"딱총 나무 지팡이", "italic":false}', minecraft:custom_model_data=2, minecraft:custom_data={tools:"edit"}]

$execute if data storage tools:player_$(id) {mode:"pos"} run tellraw @s ["", {"text":"[EDIT 모드변경] ", "bold":true}, {"text":"채우기", "color":"gold"}]
$execute if data storage tools:player_$(id) {mode:"pos"} run return run data modify storage tools:player_$(id) mode set value "set"

$execute if data storage tools:player_$(id) {mode:"set"} run tellraw @s ["", {"text":"[EDIT 모드변경] ", "bold":true}, {"text":"삭제하기", "color":"gold"}]
$execute if data storage tools:player_$(id) {mode:"set"} run return run data modify storage tools:player_$(id) mode set value "cut"

$execute if data storage tools:player_$(id) {mode:"cut"} run tellraw @s ["", {"text":"[EDIT 모드변경] ", "bold":true}, {"text":"위치설정", "color":"gold"}]
$execute if data storage tools:player_$(id) {mode:"cut"} run return run data modify storage tools:player_$(id) mode set value "pos"