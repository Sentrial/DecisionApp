extends Node2D

@onready var itemContainer = $Center/ScrollContainer/VBoxContainer
@onready var textEdit = $Center/InsertGroup/TextEdit
@onready var itemTheme = load("res://Resources/Themes/ItemTheme.tres")
@onready var trashIcon = load("res://Resources/Icons/trash-can-solid.svg")
@onready var answerLabel = $Center/Answer
@onready var glitterSFX = $Center/Answer/GlitterSFX
var items = {}

func _ready():
	pass


# Adds an item to the list
func _on_add_item_pressed():
	if textEdit.text == "":
		return
	
	# Add new item
	var newItem = HBoxContainer.new()
	newItem.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	# Creat text
	var itemText = Label.new()
	itemText.text = textEdit.text
	itemText.size_flags_horizontal = Control.SIZE_EXPAND
	itemText.theme = itemTheme
	
	# Create delete button
	var button = Button.new()
	button.icon = trashIcon
	button.expand_icon = true
	button.size_flags_horizontal = Control.SIZE_SHRINK_END
	button.custom_minimum_size = Vector2(50,50)
	button.pressed.connect(_on_delete_pressed.bind(itemText))
	
	newItem.add_child(itemText)
	newItem.add_child(button)
	button.alignment = BoxContainer.ALIGNMENT_END
	itemContainer.add_child(newItem)
	
	items[itemText.text] = true
	
	textEdit.text = ""


# Deletes the item from the list
func _on_delete_pressed(label: Label):
	items.erase(label.text)
	label.get_parent().queue_free()


# Generates a random answer
func _on_answer_pressed():
	var options = items.keys()
	var answer = "[center][b]. . .[/b][/center]"
	if len(options) > 0:
		answer = "[center][b]" + options[randi() % options.size()] + "[/b][/center]"
		glitterSFX.play()
	
	answerLabel.text = answer

func _on_clear_pressed():
	for child in itemContainer.get_children():
		itemContainer.remove_child(child)
		child.queue_free()
	items.clear()
