class_name UpgradeButton
extends Button


var _upgrade: BaseUpgrade
var lock := Mutex.new()


func get_upgrade() -> BaseUpgrade:
	return _upgrade


func set_upgrade(upgrade: BaseUpgrade):
	_upgrade = upgrade
	self.text = "%s (%d)" % [upgrade.label, upgrade.cost]
	# TODO: Show descript text on hover for 2+ seconds
	self.disabled = not _upgrade.is_purchasable()


func _on_pressed():
	lock.lock()
	if _upgrade.is_purchasable():
		_upgrade.purchase()
	lock.unlock()
