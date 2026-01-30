extends Control

@onready var game_over_ui = $MainCanvas/GameOverInterface
@onready var score_label = $MainCanvas/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_score_display(GameManager.current_score)
	GameManager.score_changed.connect(_on_game_manager_score_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_game_over_area_overflow_occurred() -> void:
	# 1. 显示 UI
	game_over_ui.visible = true
	
	
# 处理分数区域
# 这是一个内部处理函数，专门负责更新文字
func _update_score_display(new_score):
	if score_label:
		score_label.text = "Score: " + str(new_score)
# 当信号触发时执行
func _on_game_manager_score_changed(new_score):
	_update_score_display(new_score)
