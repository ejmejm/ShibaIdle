class_name UpgradeButton
extends Button

@onready var description_panel: PanelContainer = $/root/Root/UICanvas/DescriptionPanel

var _upgrade: BaseUpgrade
var lock := Mutex.new()
var base_text: String


func get_upgrade() -> BaseUpgrade:
	return _upgrade


func set_upgrade(upgrade: BaseUpgrade):
	_upgrade = upgrade
	base_text = "%s [%d]" % [upgrade.label, upgrade.cost]
	self.text = base_text
	# TODO: Show descript text on hover for 2+ seconds
	self.disabled = not _upgrade.is_purchasable()


func _on_pressed():
	lock.lock()
	if _upgrade.is_purchasable():
		_upgrade.purchase()
	lock.unlock()
	
	

func _on_button_hovered() -> void:
	description_panel.visible = true



func _on_button_unhovered() -> void:
	pass # Replace with function body.
