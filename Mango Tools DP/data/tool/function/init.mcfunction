# 스코어보드 생성
scoreboard objectives add tool.use minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add tool.id dummy
scoreboard objectives add tool.value dummy

# 변수 초기값 설정
scoreboard players add max tool.value 0
scoreboard players add idx tool.value 1

# 스토리지 초기 설정
data merge storage tool:data {global:{index:1, shader_id:"00"}}
data merge storage tool:data {player:[{id:0, shader.page:"effect", shader.change:0, shader.previous:[]}]}

# 완료
tellraw @a ["", {"text":"[MANGO TOOL] ", "color":"gold"}, "로드 완료!"]