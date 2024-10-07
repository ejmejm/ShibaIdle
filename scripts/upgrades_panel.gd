extends PanelContainer


@onready var upgrades_manager: UpgradeManager = %UpgradesManager
@onready var button_container: Control = %ButtonContainer
@onready var upgrades_header: Label = %UpgradesHeaderLabel
var upgrade_button_template: PackedScene = preload("res://scenes/upgrade_button.tscn")


## On start, create buttons for every single upgrade in order of cost
func _on_ready():
	var upgrades := upgrades_manager.get_all_upgrades()
	upgrades.sort_custom(func(a, b): return a.cost < b.cost)

	# Add buttons for each upgrade
	for upgrade in upgrades:
		var new_button: UpgradeButton = upgrade_button_template.instantiate()
		new_button.set_upgrade(upgrade)
		new_button.visible = new_button.get_upgrade().should_display()
		button_container.add_child(new_button)


func _input(event: InputEvent):
	if event.is_action_pressed("ModifierKey"):
		upgrades_header.text = "Upgrades (+10)"
	elif event.is_action_released("ModifierKey"):
		upgrades_header.text = "Upgrades"


func get_buttons() -> Array[UpgradeButton]:
	var nodes = button_container.get_children()
	var buttons: Array[UpgradeButton]
	buttons.assign(nodes)
	return buttons


## Everytime the timer goes up, show the visible upgrades and hide the others
func _on_update_timer() -> void:
	# First remove all previous buttons
	for node in button_container.get_children():
			
		var button_script: UpgradeButton = node # .get_script()
		var upgrade := button_script.get_upgrade()
		
		node.visible = upgrade.should_display()
		if node.visible:
			node.disabled = not upgrade.is_purchasable()
