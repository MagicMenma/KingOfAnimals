extends Control

@onready var game_over_ui = $MainCanvas/GameOverInterface

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_game_over_area_overflow_occurred() -> void:
	# 1. 显示 UI
	game_over_ui.visible = true
	
	# 2. 停止物理计算（让动物们在温泉里定格，很有电影感）
	get_tree().paused = true
	
	# 3. 如果你的弹窗里有按钮，确保它们能被点击
	# 后面会提到如何设置“暂停时不停止 UI”
