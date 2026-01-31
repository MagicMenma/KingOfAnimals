# GameManager.gd (设为 Autoload)
extends Node

signal score_changed(new_score) # 定义信号，用于更新 UI

var current_score: int = 0
var daily_score: int = 0
var daily_stamina: int = 3
var current_selection = []


func add_to_selection(animal):
	current_selection.append(animal)
	
	if current_selection.size() == 2:
		if not quick_match():
			return
	if current_selection.size() == 3:
		full_match()
	

func quick_match() -> bool:
	var first1 = current_selection[0]
	var second2 = current_selection[1]
	
	if first1.animal_type != second2.animal_type:
		print("类型不匹配，快速清空")
		clear_selection()
		current_selection.clear()
		return false # 返回 false 匹配失败
	return true # 返回 true 目前两个是一样的

func full_match():
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
			clear_selection()
		current_selection.clear()


# 待使用
func clear_selection():
	if current_selection.is_empty():
		return
		
	for item in current_selection:
		if is_instance_valid(item): # 确保动物还没被销毁
			item.deselected() # 取消选定

func add_score(points: int):
	current_score += points
	score_changed.emit(current_score) # 发射信号
	
func clear_score():
	current_score = 0
	score_changed.emit(current_score)
	current_selection.clear()
	
func new_day():
	daily_score = 0
