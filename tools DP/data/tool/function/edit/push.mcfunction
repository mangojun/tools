$execute if data entity @s {SelectedItemSlot:0} run title @s actionbar ["", {"text":"[EDIT $(id)] ", "bold":true}, {"text":"위치설정", "color":"gold"}]
$execute if data entity @s {SelectedItemSlot:0} run data modify storage tool:player_$(id) mode set value "pos"

$execute if data entity @s {SelectedItemSlot:1} run title @s actionbar ["", {"text":"[EDIT $(id)] ", "bold":true}, {"text":"채워넣기", "color":"gold"}]
$execute if data entity @s {SelectedItemSlot:1} run data modify storage tool:player_$(id) mode set value "set"

$execute if data entity @s {SelectedItemSlot:2} run title @s actionbar ["", {"text":"[EDIT $(id)] ", "bold":true}, {"text":"삭제하기", "color":"gold"}]
$execute if data entity @s {SelectedItemSlot:2} run data modify storage tool:player_$(id) mode set value "cut"

$execute if data entity @s {SelectedItemSlot:3} run title @s actionbar ["", {"text":"[EDIT $(id)] ", "bold":true}, {"text":"변경하기", "color":"gold"}]
$execute if data entity @s {SelectedItemSlot:3} run data modify storage tool:player_$(id) mode set value "rpl"