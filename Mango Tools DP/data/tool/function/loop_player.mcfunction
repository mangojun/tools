# 인덱스 범위를 벗어나면 1로 초기화하고 종료
$execute unless entity @a[scores={tool.id=$(index)}] run return run scoreboard players set idx tool.value 1

## 각 인덱스 플레이어에 대해 실행
# 셰이더 눈
$execute as @a[scores={tool.id=$(index)}] at @s if items entity @s weapon.offhand minecraft:carrot_on_a_stick[minecraft:custom_data={tool:{item:"shader"}}] run function tool.shader:offhand {id:$(index)}
$execute as @a[scores={tool.id=$(index)}] at @s if items entity @s weapon.mainhand minecraft:carrot_on_a_stick[minecraft:custom_data={tool:{item:"shader"}}] run function tool.shader:mainhand {id:$(index)}
$execute as @a[scores={tool.id=$(index)}] at @s if items entity @s weapon.mainhand minecraft:carrot_on_a_stick[minecraft:custom_data={tool:{item:"shader"}}] if score @s tool.use matches 1.. run function tool.shader:click {id:$(index)}

# 인덱스에 1 더하고 스토리지 거쳐 재귀
execute store result storage tool:data global.index int 1 run scoreboard players add idx tool.value 1
function tool:loop_player with storage tool:data global