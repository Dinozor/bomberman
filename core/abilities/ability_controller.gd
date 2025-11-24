class_name AbilityController
extends Node

# Ability and if it is enabled
var _abilities: Dictionary[Ability, bool]


func enable_ability(_ability: Ability) -> void:
	pass


func disable_ability(_ability: Ability) -> void:
	pass


func add_ability(ability: Ability, enabled: bool = true) -> void:
	_abilities[ability] = enabled
