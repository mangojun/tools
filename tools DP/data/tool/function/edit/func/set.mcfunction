$execute unless block $(1stX) $(1stY) $(1stZ) $(2ndB) run title @s actionbar ["", {"text":"[EDIT $(id)] ", "bold":true}, {"text":"$(1stX) ", "color":"red"}, {"text":"$(1stY) ", "color":"green"}, {"text":"$(1stZ)", "color":"blue"}, "부터 ", {"text":"$(2ndX) ", "color":"red"}, {"text":"$(2ndY) ", "color":"green"}, {"text":"$(2ndZ)", "color":"blue"}, "까지 ", {"text":"$(2ndB) ", "color":"gold"}, "을(를) 설치했습니다"]
$execute unless block $(1stX) $(1stY) $(1stZ) $(2ndB) run return run fill $(1stX) $(1stY) $(1stZ) $(2ndX) $(2ndY) $(2ndZ) $(2ndB)

$execute if block $(1stX) $(1stY) $(1stZ) $(2ndB) run title @s actionbar ["", {"text":"[EDIT $(id)] ", "bold":true}, {"text":"$(1stX) ", "color":"red"}, {"text":"$(1stY) ", "color":"green"}, {"text":"$(1stZ)", "color":"blue"}, "부터 ", {"text":"$(2ndX) ", "color":"red"}, {"text":"$(2ndY) ", "color":"green"}, {"text":"$(2ndZ)", "color":"blue"}, "까지 ", {"text":"$(1stB) ", "color":"gold"}, "을(를) 설치했습니다"]
$execute if block $(1stX) $(1stY) $(1stZ) $(2ndB) run return run fill $(1stX) $(1stY) $(1stZ) $(2ndX) $(2ndY) $(2ndZ) $(1stB)