# 커맨드 출력
tellraw @s ["", {"text": "/data merge storage tool:data {global:{shader_id:'"}, {"storage": "tool:data", "nbt": "global.shader_id"}, {"text": "'}}"}]

# 스코어 리셋
scoreboard players reset @s tool.use