$execute unless block $(2ndX) $(2ndY) $(2ndZ) $(block) run loot spawn ~ ~ ~ mine $(2ndX) $(2ndY) $(2ndZ) minecraft:stick[minecraft:enchantments={levels:{"minecraft:silk_touch":1}}]
$execute unless block $(2ndX) $(2ndY) $(2ndZ) $(block) run data modify storage tools:player_1 block set from entity @e[type=item, limit=1, sort=nearest] Item.id
$execute unless block $(2ndX) $(2ndY) $(2ndZ) $(block) run kill @e[type=item, limit=1, sort=nearest]
$execute unless block $(2ndX) $(2ndY) $(2ndZ) $(block) run return run function tools:edit/set with storage tools:player_$(id)

$fill $(1stX) $(1stY) $(1stZ) $(2ndX) $(2ndY) $(2ndZ) $(block)
$tellraw @s ["", {"text":"[EDIT 채우기] ", "bold":true}, {"text":"$(1stX) ", "color":"red"}, {"text":"$(1stY) ", "color":"green"}, {"text":"$(1stZ)", "color":"blue"}, "부터 ", {"text":"$(2ndX) ", "color":"red"}, {"text":"$(2ndY) ", "color":"green"}, {"text":"$(2ndZ)", "color":"blue"}, "까지 ", {"text":"$(block) ", "color":"gold"}, "을(를) 설치했습니다"]