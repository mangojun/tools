# 총괄
execute as @a unless score @s id = @s id store result score @s id run scoreboard players add max id 1
tag @r[nbt={SelectedItem:{id:"minecraft:carrot_on_a_stick"}}] add tooler
tag @r[nbt={Inventory:[{Slot:-106b, id:"minecraft:carrot_on_a_stick"}]}] add tooler
execute as @a[tag=tooler] store result storage tool:temp id int 1 run scoreboard players get @s id
function tool:global/storage with storage tool:temp
execute if data storage tool:temp {id:0} run say me

# 입체 기동 장치
execute as @a[tag=tooler, nbt={SelectedItem:{components:{"minecraft:custom_data":{tool:"hook"}}}}] at @s if score @s click matches 1.. positioned ~ ~1.7 ~ run function tool:hook/click with storage tool:temp
execute as @a[tag=tooler, nbt={Inventory:[{Slot:-106b, components:{"minecraft:custom_data":{tool:"hook"}}}]}] run function tool:hook/push with storage tool:temp
execute as @a[tag=tooler, nbt={SelectedItem:{components:{"minecraft:custom_data":{tool:"hook"}}}}] run function tool:hook/hold with storage tool:temp

# 딱총 나무 지팡이
execute as @a[tag=tooler, nbt={SelectedItem:{components:{"minecraft:custom_data":{tool:"edit"}}}}] at @s if score @s click matches 1.. positioned ~ ~1.7 ~ run function tool:edit/click with storage tool:temp
execute as @a[tag=tooler, nbt={Inventory:[{Slot:-106b, components:{"minecraft:custom_data":{tool:"edit"}}}]}] run function tool:edit/push with storage tool:temp

# 끝
tag @a remove tooler