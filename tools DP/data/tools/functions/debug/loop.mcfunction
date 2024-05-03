# 총괄
execute as @a unless score @s id = @s id store result score @s id run scoreboard players add max id 1
execute as @r store result storage tools:temp id int 1 run scoreboard players get @s id
function tools:debug/storage with storage tools:temp

# 딱총 나무 지팡이
execute as @a[nbt={SelectedItem:{components:{"minecraft:custom_data":{tools:"edit"}}}}] at @s if score @s click matches 1.. positioned ~ ~1.7 ~ run function tools:edit/click with storage tools:temp
execute as @a[nbt={Inventory:[{Slot:-106b, components:{"minecraft:custom_data":{tools:"edit"}}}]}] run function tools:edit/push with storage tools:temp

# 입체 기동 장치
execute as @a[nbt={SelectedItem:{components:{"minecraft:custom_data":{tools:"hook"}}}}] at @s if score @s click matches 1.. positioned ~ ~1.7 ~ run function tools:hook/click with storage tools:temp