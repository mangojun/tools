# id에 맞는 파티클로 셰이더 보이기
$execute as @a at @s run particle entity_effect{color:[1.0, 0.0, 0.$(shader_id), 1.0]} ~ ~ ~