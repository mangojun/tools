# 스토리지, ID 부여
execute as @a unless score @s tool.id = @s tool.id run data modify storage tool:data player append from storage tool:data player[0]
execute as @a unless score @s tool.id = @s tool.id store result storage tool:data player[-1].id int 1 run scoreboard players add max tool.value 1
execute as @a unless score @s tool.id = @s tool.id store result score @s tool.id run data get storage tool:data player[-1].id

# 플레이어 루프
function tool:loop_player {index:1}

# 셰이더 눈
function tool.shader:show with storage tool:data global