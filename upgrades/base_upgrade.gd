class_name BaseUpgrade


var name: String
var description: String
var cost: int
var max_purchases: int # Maximum, number of times this upgrade can be purchased

var n_purchases: int = 0 # Number of times this upgrade has been purchased so far


func _on_purchase_logic():
	push_error("Must implement custom purchase logic!")


func _is_purchasable_logic() -> bool:
	return true


func on_purchase():
	n_purchases += 1
	_on_purchase_logic()


func is_purchasable() -> bool:
	return _is_purchasable_logic() and n_purchases < max_purchases
