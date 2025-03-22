# 스코어보드 삭제
scoreboard objectives remove tool.use
scoreboard objectives remove tool.id
scoreboard objectives remove tool.value

# 스토리지 삭제
data remove storage tool:data global
data remove storage tool:data player

# 도구 삭제
clear @a carrot_on_a_stick[custom_data~{tool:{}}]

# 엔티티 삭제
execute as @e[tag=tool.ui] run data remove entity @s Items
kill @e[tag=tool.ui]

# 완료
tellraw @a ["", {"text": "[MANGO TOOL] ", "color": "gold"}, "삭제 완료!"]