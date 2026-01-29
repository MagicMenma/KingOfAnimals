extends Area2D

@onready var check_timer = $CheckTimer

func _ready():
	# 连接信号：当有物体进入区域时
	body_entered.connect(_on_body_entered)
	# 连接信号：当有物体离开区域时
	body_exited.connect(_on_body_exited)
	# 连接信号：计时器到时
	check_timer.timeout.connect(_on_game_over_triggered)

func _on_body_entered(body):
	if body is RigidBody2D:
		# 如果检测区域内没有计时在运行，就开始计时
		if check_timer.is_stopped():
			check_timer.start()

func _on_body_exited(_body):
	# 检查区域内是否还有其他动物
	var overlapping_bodies = get_overlapping_bodies()
	var has_animals = false
	for b in overlapping_bodies:
		if b is RigidBody2D:
			has_animals = true
			break
	
	# 如果所有动物都掉下去了（离开了区域），停止计时器
	if not has_animals:
		check_timer.stop()

func _on_game_over_triggered():
	print("游戏失败！物体溢出！")
	# 找到你的生成器并停止它
	var spawner = get_tree().root.find_child("AnimalSpawner", true, false)
	if spawner:
		spawner.stopSpawning = true
	
	# 这里可以触发展示游戏结束的 UI
	# ShowGameOverUI()
