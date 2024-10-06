class_name UpgradeButton
extends Button


var _upgrade: BaseUpgrade


func get_upgrade() -> BaseUpgrade:
	return _upgrade


func set_upgrade(upgrade: BaseUpgrade):
	_upgrade = upgrade
	self.text = upgrade.label
	# TODO: Show descript text on hover for 2+ seconds
	self.disabled = not _upgrade.is_purchasable()


func _on_pressed():
	if _upgrade.is_purchasable():
		_upgrade.purchase()



#@onready var upgrade_node: Node = $UpgradeScriptHolder
#var _upgrade: BaseUpgrade
#
#
#func get_upgrade() -> BaseUpgrade:
	#return _upgrade
#
#
#func set_upgrade(upgrade: BaseUpgrade):
	#upgrade_node.set_script(upgrade)
	#_upgrade = upgrade_node.get_script()
	#self.text = upgrade.label
	## TODO: Show descript text on hover for 2+ seconds
	#self.disabled = not upgrade_node.is_purchasable()
