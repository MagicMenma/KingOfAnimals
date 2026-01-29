extends RigidBody2D

# 使用 @export 关键字，让你在检查器面板就能直接修改这些值
@export var animal_type: String = "Capybara" # 用于判断是否可以消除
@export var score_value: int = 100            # 不同动物的分数
@export var hover_color: Color = Color.WHITE # 高亮颜色

var is_selected = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		toggle_selection()

func toggle_selection():
	is_selected = !is_selected
	print("selected")
	# 所有的动物都共用这一套高亮和选中逻辑
	$Sprite2D.material.set_shader_parameter("active", is_selected)
	$Sprite2D.material.set_shader_parameter("line_color", hover_color)
	
	
	#if is_selected:
		#GameManager.add_to_selection(self)
	#else:
		#GameManager.remove_from_selection(self)
