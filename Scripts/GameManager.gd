# GameManager.gd (设为 Autoload)
extends Node

signal score_changed(new_score) # 定义信号，用于更新 UI

var current_score: int = 0
var daily_score: int = 0
var daily_stamina: int = 2
var current_selection = []

func add_to_selection(animal):
	current_selection.append(animal)
	print("当前已选择: ", current_selection.size(), "/3")
	
	if current_selection.size() == 3:
		check_match()

func check_match():
	var first = current_selection[0]
	var second = current_selection[1]
	var third = current_selection[2]
	
	# 比较 animal_type 属性
	if first.animal_type != null and second.animal_type != null and third.animal_type != null:
		if first.animal_type == second.animal_type and second.animal_type == third.animal_type:
			add_score(third.score_value)
			
			for item in current_selection:
				# 播放消失动画（这里可以用 Tween 让它缩小）
				var tween = create_tween()
				tween.tween_property(item, "scale", Vector2.ZERO, 0.2)
				tween.finished.connect(item.queue_free) 
		else:
			for item in current_selection:
				item.toggle_selection() # 调用你之前写的高亮切换函数取消高亮
		current_selection.clear()

func clear_selection():
	if current_selection.is_empty():
		return
		
	print("点击了空白区域，取消所有选择")
	for item in current_selection:
		if is_instance_valid(item): # 确保动物还没被销毁
			item.toggle_selection() # 取消高亮
	current_selection.clear()

func add_score(points: int):
	current_score += points
	score_changed.emit(current_score) # 发射信号
	print("当前分数: ", current_score)
	
func clear_score():
	current_score = 0
	score_changed.emit(current_score)
	current_selection.clear()
	
func new_day():
	daily_score = 0
