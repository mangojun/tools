# 스케줄로 실행된 함수 실행자를 사람으로 바꾸기
$execute unless entity @s[type=player] run return run execute as @a[nbt={UUID:$(UUID)}] at @s run function tools:hook/main {UUID: $(UUID)}

# 레이케스팅으로 블록 위치 찾기
$execute if block ~ ~1 ~ air positioned ^ ^ ^0.1 run return run function tools:hook/main {UUID:$(UUID)}

# 끈 소환 & 플레이어 중력 삭제
$execute unless entity @e[tag=hook, nbt={Leash:{UUID:$(UUID)}}] run summon minecraft:bat ~ ~1 ~ {NoAI:true, Silent:true, Invulnerable:true, Tags:["hook"], Leash:{UUID: $(UUID)}, active_effects:[{duration:-1, id:"minecraft:invisibility", show_particles:false}]}
effect give @s minecraft:levitation infinite 255 true

# 1틱마다 스케줄로 앞으로 이동하며 실행, 파티클 소환
$execute if entity @e[tag=hook, nbt={Leash:{UUID:$(UUID)}}, distance=1..] run data modify storage tools:hook UUID set from entity @s UUID
$execute as @a[nbt={UUID:$(UUID)}] at @s if entity @e[tag=hook, nbt={Leash:{UUID:$(UUID)}}, distance=1..] run schedule function tools:hook/macro 1t append
$execute as @a[nbt={UUID:$(UUID)}] at @s if entity @e[tag=hook, nbt={Leash:{UUID:$(UUID)}}, distance=1..] run particle minecraft:cloud ~ ~ ~
$execute as @a[nbt={UUID:$(UUID)}] at @s if entity @e[tag=hook, nbt={Leash:{UUID:$(UUID)}}, distance=1..] facing entity @e[tag=hook, nbt={Leash:{UUID:$(UUID)}}] feet run tp @s ^ ^ ^1

# 도착하면 끈 죽이고 스케줄 삭제, 플레이어 중력 다시 넣기
$execute unless block ~ ~1 ~ minecraft:air as @a[nbt={UUID:$(UUID)}] at @s if entity @e[tag=hook, nbt={Leash:{UUID:$(UUID)}}, distance=..1] run effect clear @s minecraft:levitation
$execute unless block ~ ~1 ~ minecraft:air as @a[nbt={UUID:$(UUID)}] at @s if entity @e[tag=hook, nbt={Leash:{UUID:$(UUID)}}, distance=..1] run schedule clear tools:hook/macro
$execute unless block ~ ~1 ~ minecraft:air as @e[tag=hook, nbt={Leash:{UUID:$(UUID)}}] at @s if entity @a[nbt={UUID:$(UUID)}, distance=..1] run kill @s

# 최종
$scoreboard players reset @a[nbt={UUID:$(UUID)}] click