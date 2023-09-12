extends CanvasLayer

@onready var health_number: Label = $HealthNumber

func update_health(new_health: int) -> void:
	health_number.text = str(new_health)
