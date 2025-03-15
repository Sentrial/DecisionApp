extends Node2D

@onready var itemContainer = $Center/ScrollContainer/VBoxContainer
@onready var itemTheme = load("res://Resources/Themes/ItemTheme.tres")
@onready var answerLabel = $Center/Answer
@onready var glitterSFX = $Center/Answer/GlitterSFX
@onready var optionPrefab = preload("res://Scenes/option.tscn")

func _ready():
	pass


func _on_add_option_pressed():
	var newOption = optionPrefab.instantiate()
	var pos = max(0, itemContainer.get_child_count() - 1)
	newOption.get_child(0).placeholder_text = "Option " + str(pos + 1) + " . . ."
	itemContainer.add_child(newOption)
	itemContainer.move_child(newOption, pos)


# Generates a random answer
func _on_answer_pressed():
	var options = []
	var items = itemContainer.get_children()
	for item in items:
		for child in item.get_children():
			if child is LineEdit:
				if child.text != "":
					options.append(child.text)
	
	if len(options) > 0:
		answerLabel.text = "[center][b]" + options[randi() % options.size()] + "[/b][/center]"
		glitterSFX.play()
	

func _on_reset_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_about_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/about.tscn")
