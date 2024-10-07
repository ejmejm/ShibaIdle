extends InuController

@onready var sprite_double: Sprite2D = $ShibaSpriteStationaryDouble
@onready var animated_sprite_double: AnimatedSprite2D = $ShibaSpriteDouble

#overide of inucontroller to also activate second sprite's animation 
#I know new sprite is better but our artist went to bed
func _ready():
	super()
	animated_sprite_double.play()

#override of physics to enable direction for both sprites
#I know new sprite is better but our artist went to bed
func _physics_process(delta):
	super(delta)
	if velocity.y == 0 and velocity.x == 0:
		animated_sprite_double.visible = false
		sprite_double.visible = true

	else:
		animated_sprite_double.visible = true
		sprite_double.visible = false
		
func move_towards_target():
	super()
		#determine direction inudouble should face
	if velocity.x > 0:
		animated_sprite_double.flip_v = 0
		animated_sprite_double.rotation = velocity.angle()
	else:
		animated_sprite_double.flip_v = 1
		animated_sprite_double.rotation = velocity.angle()
